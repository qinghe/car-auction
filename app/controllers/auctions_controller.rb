#encoding: utf-8
class AuctionsController < ApplicationController
  layout 'frontend'
  before_filter :to_search_event, :only => [:search, :result]
  skip_before_filter :authenticate, :except=>[:apply, :start, :bid]
  before_filter :load_auction, :except=>[:index, :search, :result]
  before_filter :to_bidding, :only=> [:start, :bid, :close ]

  def index
    #per page = 20
    @auctions = Auction.public_auctions.with_status(:active).open.order("start_at").paginate(:page => params[:page], :per_page => 18)
    #@users = User.count
    @blogs = Blogpost.order("id DESC").limit(18).includes(:user)
    #@projects = Project.where(:status => Project::STATUSES[:active]).count
    title_t
  end

  # ajax for enable bidding, update auction form  
  def start 
    render :partial=>"start.js.erb"
  end
  
  def close
    if @auction.closed? and @auction.won_offer.blank?
      @auction.close!
    end
    
    render :partial=>"close", :handlers=>[:erb]    
  end
  
  # ajax post only
  def bid
    #"offer"=>{"price"=>"14000.0"}
    @offer = @auction.new_offer(params[:offer])
    @offer.auction_id = @auction.id
    @offer.offerer_id = current_user.id
logger.debug "@offer.price=#{@offer.price}, @auction.current_price=#{@auction.current_price}"    
    if @offer.price > @auction.current_price
      @offer.save!
    end 
    render :partial=>"bid.js.erb"
    
  end

  def show

    @made_offer = @auction.made_offer?(current_user)
    #@auction.expired_at many be nil
    if @auction.expired_at and @auction.expired_at.past?
      @auction.status = Auction::STATUSES[:finished]
    end

    unless (@auction.allowed_to_see?(current_user))
      render :text => t("flash.general.error.privileges"), :status => :forbidden
      return
    end

    @offers = @auction.offers
    @tags = @auction.tags

    @alert = Alert.new
    @auction.increment! :visits
    
    unless current_user.nil?
    	@rated = @auction.rated_by?(current_user) || @auction.owner?(current_user)
    end
    title_t
  end

  # apply for bid
  def apply

    data = params[:message] || {:topic => "apply to bid #{@auction.id}"}
    @message = current_user.new_message(data)
    if request.post?
      @message.auction_id = @auction.id
      @message.receiver_id = @auction.auctioneer_id
      @message.author_id = current_user.id
      if @message.send_to_receiver
        #Sender.user_received_message(@message).deliver
        redirect_to applied_auction_path(@auction)
      else
        render  "apply_to_bid"
      end
      return
    end
    render 'apply_to_bid'    
  end
  
  def applied

  end

  def search
    title_t
  end
  
  def result
    @query = params[:query] ||= ''
    @search_in_description = params[:search_in_description] ||= false
    @show_tags = false #params[:show_tags] ||= false #tagi wyswietlane od razu po zaladowaniu formularza
    @elapsed_time = Benchmark.realtime do |x|
      @auctions = Auction.search_by_sphinx(@query, @search_in_description, @selected_tag_ids, @budgets_ids)#Auction.has_tags.all {@selected_tags})
    end
    title_t
  end
  
  private

  def to_search_event
    params[:tag_ids] = {params[:tag_ids] => params[:tag_ids]} if params[:tag_ids].instance_of?(String)
    @selected_tag_ids = (params[:tag_ids] || Hash.new).values.collect{|tag| tag.to_i}
    @groups = Group.all
    @budgets_ids = (params[:budgets_ids] || Hash.new).values
  end
  
  def to_bidding
    @auction.allowed_to_offer?(@current_user)
  end
  
  def load_auction
    options = {:include => [:owner, {:offers => :offerer}, :communications]}
    @auction = Auction.find(params[:id], options)
  end
end
