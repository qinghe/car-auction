# encoding: utf-8
class Car < ActiveRecord::Base
  attr_accessible :engine_number, :frame_number, :is_at, :model_id, :model_name, :plate_number, :registered_at, :serial_no, :displacement
  belongs_to :publisher, :class_name => 'User'
  belongs_to :evaluator, :class_name => 'User'

  has_many :accidents, :dependent => :destroy
  has_many :car_files, :dependent => :destroy
  
  has_many :license_files, :conditions=>{:type=>0}, :class_name =>'CarFile'
  has_many :frame_files, :conditions=>{:type=>1}, :class_name =>'CarFile'
  has_many :accident_files, :conditions=>{:type=>2}, :class_name =>'CarFile'
  
  has_one :auction, :dependent => :destroy
  attr_accessible :accidents_attributes, :license_files_attributes, :frame_files_attributes, :accident_files_attributes, :auction_attributes
  accepts_nested_attributes_for :accidents, :license_files,:frame_files,:accident_files, :auction
  
  #DISPLACEMENTS={'','1.2'=>12,'1.5'=>15,'1.6'=>16,'2.4'=>24} #排量
  
  CARPROCESS = {'0'=>"待评估车辆",'1'=>"待处理车辆",'2'=>"委托车辆",'3'=>"待提车辆",'4'=>"过户车辆"}

  def self.list_by(process_method)
    self.includes("accidents").where("accidents.chuli_fangshi =#{process_method}").all
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

  def publish_agency
    self.publisher ? "#{self.publisher.company.name}-#{self.publisher.role}" : "保险公司"
  end

  def insurance_company_responsible_person
    self.publisher ? self.publisher.name : "保险公司"
  end

  def evaluating_company_responsible_person
    self.evaluator ? self.evaluator.name : "华晨"
  end
end
