# encoding: utf-8
class Car < ActiveRecord::Base
  attr_accessible :engine_number, :frame_number, :variator, :model_id, :model_name, :plate_number, :registered_at, :serial_no, :displacement, :status, :bidding_price,
                  :final_compensate_price, :owner_name, :owner_phone, :pickup_contact_person, :pickup_contact_phone, :pay_method, :pickup_start_at, :pickup_expired_at,
                  :pickup_address, :giveup_auction_reason, :giveup_pickupcar_reason,
                  :publisher_id, :evaluator_id

  belongs_to :publisher, :class_name => 'User'
  belongs_to :evaluator, :class_name => 'User'

  has_one :accident, :dependent => :destroy
  has_many :car_files, :dependent => :destroy
  
  has_many :car_license_images, :class_name =>'CarLicenseImage'
  has_many :car_frame_images, :class_name =>'CarFrameImage'
  has_many :car_images,  :class_name =>'CarImage'
  has_many :attachment_files, :class_name =>'CarFile'

  has_one :auction, :dependent => :destroy
  belongs_to :model, :class_name=>'CarModel'
  attr_accessible :accident_attributes, :auction_attributes, :car_license_image_ids, :car_frame_image_ids, :car_image_ids
  accepts_nested_attributes_for :accident, :auction
  
  #DISPLACEMENTS={'','1.2'=>12,'1.5'=>15,'1.6'=>16,'2.4'=>24} #排量
  VARIATORS={'MT'=>0,'AT'=>1,'A/MT'=>2, 'CVT'=>3}

  CARPROCESS = {'0'=>"待评估车辆",'1'=>"待处理车辆",'2'=>"委托车辆",'3'=>"待提车辆",'4'=>"过户车辆",'5'=>"放弃委托拍卖",'6'=>"放弃提车"}
  PAYMETHOD = {'0'=>"保险公司",'1'=>"车主"}

  validates :serial_no, :presence => true, :length => {:within => 1..40}
  validates :engine_number, :presence => true, :length => {:within => 2..40}
  validates :frame_number, :presence => true, :length => {:within => 2..40}
  validates :plate_number, :presence => true, :length => {:within => 2..40}

  def self.list_by(process_method,current_user)
    if current_user.role == "insurance"
      user_ids = current_user.company.members.collect{|m|m.id}
      return self.where("status =#{process_method} and publisher_id in (#{user_ids.join(',')})").all
    else
      return self.where("status =#{process_method}").all
    end
  end

  def limitation
    seconds = Time.now.utc - created_at.utc
    '%d 天 %d 小时 %d 分钟 %d 秒' %
        # the .reverse lets us put the larger units first for readability
        [24,60,60].reverse.inject([seconds]) {|result, unitsize|
          result[0,0] = result.shift.divmod(unitsize)
          result
        }
  end

  def get_bidding_price
    auction ? auction.bidding_price : 0
  end

  def insurance_responsible_person
    self.publisher ? self.publisher.name : "保险公司"
  end

  def evaluating_responsible_person
    self.evaluator ? self.evaluator.name : "华晨"
  end

  def name
    self.model.present? ? self.model.name : model_name
  end

  def variator_name
    VARIATORS.key(variator)
  end

  def status?( some_status)
    self.status == some_status
  end
end
