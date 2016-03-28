# encoding: utf-8
class Auction < ActiveRecord::Base
  #attr_protected :status, :hightlight
  AuctionTypeEnum = Struct.new( :salesroom, :internet) ['1', '2']
  FeedbackEnum = Struct.new( :yes, :no) ['1', '2']

  STATUSES = {:active => 0, :finished => 1, :canceled => 2, :waiting_for_offer => 3}
  MAX_EXPIRED_AFTER = 14
  ORDER_MODES = [
    ["po nazwie", "title DESC", 0],
    ["po statusie", "status ASC", 1],
    ["po ID malejaco", "id DESC", 2],
    ["po ID rosnaco", "id ASC", 3],
    ["po OCENIE malejaco", "rating DESC", 4],
    ["po OCENIE rosnaco", "rating ASC", 5]
  ]

  belongs_to :owner, :class_name => 'User'      #insurance company
  belongs_to :won_offer, :class_name => 'Offer'
  has_many :offers, :dependent => :destroy #bid
  has_many :communications, :dependent => :delete_all
  has_and_belongs_to_many :tags,
    :after_add => :tag_counter_up,
    :after_remove => :tag_counter_down
  has_and_belongs_to_many :invited_users, :class_name => "User"
  has_many :rating_values, :class_name => 'AuctionRating', :dependent => :delete_all,
    :after_add => :calculate_rating,
    :after_remove => :calculate_rating
  has_one :project
  belongs_to :budget

  belongs_to :auctioneer, :class_name => 'User' #huachen company
  belongs_to :car

  #validates :price_increment, :numericality => {:greater_than => 0}
  #validates :reserve_price, :numericality => {:greater_than => 0}

 # ThinkingSphinx::Index.define :auction, :with => :active_record do
 #   indexes :title
 #   indexes :description
 #   #indexes :budget_id
 #   indexes tags(:id), :as => :tags_ids
 #   has :expired_at
 #   where 'auctions.private = 0 AND auctions.expired_at > NOW()'
 #   #set_property :delta => true
 # end

  #validates :title, :presence => true, :length => { :within => 8..50}
  #validates :description, :presence => true
  validates_inclusion_of :status, :in => STATUSES.values
  #validates_inclusion_of :budget_id, :in => Budget.ids

  scope :has_tags, lambda { |tags| {:conditions => ['id in (SELECT auction_id FROM auctions_tags WHERE tag_id in (?))', tags.join(',')]}}
  scope :with_status, lambda { |status| where(:status => STATUSES[status.to_sym])}
  scope :online, lambda { where(:status => STATUSES[:active])}
  scope :public_auctions, lambda { where(:private => false)}

  scope :within_today, lambda { where(["(start_at > ?) and (expired_at < ?)", Date.current.to_time.beginning_of_day, Date.current.to_time.end_of_day])}
  scope :closed, lambda { where(["expired_at > ? ",Time.now])}
  scope :opened, lambda { where(["(start_at < ?) and (expired_at > ?)", Time.now, Time.now])}
  scope :open, lambda { where(["start_at > ? ",Time.now]) }


  before_validation :init_auction_row, :on => :create
  before_update :won_offer_choosed, :if => :won_offer_id_changed?
  before_update :status_changed, :if => :down?
  before_validation :check_points, :on => :create, :if => :highlight
  after_create :use_points, :if => :highlight

  #create form
  attr_accessor :expired_after
  #validates_inclusion_of :expired_after, :in => (1..MAX_EXPIRED_AFTER).to_a.collect{|d| d}, :on => :create
  def open?
    (self.start_at.present?) and (status? :active) and ( self.start_at.future? )
  end

  def opened?
    (self.start_at.present?) and (status? :active) and ( DateTime.now > self.start_at ) and  ( DateTime.now < self.expired_at )
  end

  def closed?
    (self.start_at.present?) and ( DateTime.now > self.expired_at )
  end

  def close! #choose_win_offer
    offer = self.offers.order("price DESC").first
    unless offer.present?
      offer = new_offer( :price =>( self.starting_price > self.car.canzhi_jiazhi ?  self.starting_price : self.car.canzhi_jiazhi),:offerer_id => self.car.evaluator_id )
      offer.save!
    end
    set_won_offer!(offer)
    finish!
    car.to_status!(3)
  end

  def bidding_price
    self.won_offer ? self.won_offer.price : 0
  end

  def bidding_result
    bidding_price - reserve_price > 0 ? "中标价超过保留价" : "中标价等于或低于保留价"
  end

  def current_price
    if self.offers.present?
      self.offers.collect(&:price).max
    else
      self.starting_price
    end
  end
  #设置取消拍卖状态
  def cancel!
    self.status = STATUSES[:canceled]
    self.save
  end

  def finish!
    self.status = STATUSES[:finished]
    self.save
  end

  def waiting_for_offer!
    self.status = STATUSES[:waiting_for_offer]
    self.save
  end

  def set_won_offer! offer
    return false unless offer.auction_id == self.id
    self.won_offer = offer
    self.save
  end

  #czy uzytkownik moze zlozyc oferte
  def allowed_to_offer? user
    return false if user.nil? || self.owner?(user) #|| self.made_offer?(user)
    return true if user.evaluator?
    return true if user.deposit >= self.deposit
    #unnecessary but in most cases will end before its time
    #return true if self.public?

    #jesli zaproszony do aukcji
    self.invited?(user)
  end

  def rate user, value
    self.rating_values.create :value => value, :user => user
  end

  def rated_by? user
    self.rating_values.exists?(:user_id => user.id)
  end

  def allowed_to_rate? user
    return false if user.nil?
    not self.rated_by?(user)
  end

  def status? status_symbol
    self.status == STATUSES[status_symbol]
  end

  def won_offer_exists?
    self.won_offer_id != nil
  end

  #用户是否是拍卖的所有者
  def owner? user
    return false if user.nil?
    self.owner_id == user.id
  end

  def invited? user
    self.invited_users.exists?(:id => user.id)
  end

  #是否公开拍卖
  def public?
    private == false
  end

  #该用户是否有权观看拍卖
  def allowed_to_see? user
    return true if public? || self.owner?(user)
    return false if (not public?) && user.eql?(nil)
    #检查用户是否被邀请参加拍卖
    self.invited?(user)
  end

  #czy oferent złożył już oferte na aktualnym etapie
  def made_offer?(user)
    return false if user.nil?
    self.offers.where(:offerer_id => user.id).count > 0
  end

  def self.search_by_sphinx(query = '', search_in_description = false,
      tags_ids = [], budget_ids = [], order = nil, page = 1, per_page = 15)

    unless search_in_description || query.length == 0
      query = '@title ' + query
    end

    unless tags_ids.empty?
      #options.merge! :weights => {:tag_list => 2}
      query += ' @tags_ids '+tags_ids.join(' | ')+''
    end

    unless budget_ids.empty?
      #options.merge! :weights => {:tag_list => 2}
      query += ' @budget_id '+budget_ids.join(' | ')+''
    end
    now = DateTime.now

    Auction.search query,
      :field_weights => {:tags_ids => 3, :title => 2, :description => 1},
      :per_page => per_page,
      :page => page,
      :sort_mode => :extended,
      :match_mode => :extended,
      :with => {:expired_at => now..(now+MAX_EXPIRED_AFTER.days)},
      :order => order || "@rank DESC"
  end

  def new_offer params
    self.offers.new params do |o|
      o.status = Offer::STATUSES[:active]
    end
  end

  #wyszukiwanie aukcji dla admina
  def self.admin_search(query = "", selected_date = nil, status = Array.new, order = 0, page = 1)
    criteria = self.includes(:owner)
    criteria.order(ORDER_MODES[order][1])

    unless query.empty?
      criteria = criteria.where("auctions.title like ? OR auctions.id=?", "%#{query}%", query)
    end

    unless selected_date.nil?
      criteria = criteria.where("DATE(auctions.created_at)=?", selected_date)
    end

    unless status.empty?
      criteria = criteria.where(:status => status)
    end

    criteria.paginate(:per_page => 15, :page => page)
  end

  def update_offers params
    return true if params.nil?

    status_won = Offer::STATUSES[:won]
    saved = true
    self.offers.each do |offer|
      offer_id = offer.id.to_s
      if params.has_key? offer_id
        save = offer.update_attributes(params[offer_id])
        saved = false if save == false
      end
    end
    saved
  end

  private
  def down?
    self.status_changed? && [STATUSES[:canceled], STATUSES[:finished]].include?(self.status)
  end

  def init_auction_row
    #self.expired_after = self.expired_after.to_i
    if self.expired_at.blank?
      #self.expired_at = self.start_at + MAX_EXPIRED_AFTER.days
    end
    #self.status = STATUSES[:active]
  end

  def tag_counter_up tag
    tag.increment! :auction_count
  end

  def tag_counter_down tag
    tag.decrement! :auction_count
  end

  def won_offer_choosed
    self.status = STATUSES[:finished]

    self.won_offer.status = Offer::STATUSES[:won]
    self.won_offer.save
  end

  def status_changed
    self.expired_at = DateTime.now
    self.tags.delete_all
  end

  def calculate_rating(v1)
    if self.rating_values.count>0
      # self.rating_values may contain new_record, value is nil.
      self.update_attribute(:rating, self.rating_values.sum(:value).to_i / self.rating_values.count)
    end
  end

  def use_points
    self.owner.bonuspoints.use!(-10, self.owner_id, 4) if self.highlight
  end

  def check_points
    points = self.owner.bonuspoints.sum(:points)
    if points-10 < 0
      self.errors.add(:highlight, I18n.t("activerecord.errors.models.auction.attributes.highlight.not_enought_points"))
    end
  end
end
