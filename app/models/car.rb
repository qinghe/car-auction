class Car < ActiveRecord::Base
  attr_accessible :engine_number, :frame_number, :is_at, :model_id, :model_name, :plate_number, :registered_at, :serial_no, :displacement
  has_many :accidents, :dependent => :destroy
  has_many :car_files, :dependent => :destroy
  
  has_many :license_files, :conditions=>{:type=>0}, :class_name =>'CarFile'
  has_many :frame_files, :conditions=>{:type=>1}, :class_name =>'CarFile'
  has_many :accident_files, :conditions=>{:type=>2}, :class_name =>'CarFile'
  
  has_one :auction, :dependent => :destroy
  attr_accessible :accidents_attributes, :license_files_attributes, :frame_files_attributes, :accident_files_attributes, :auction_attributes
  accepts_nested_attributes_for :accidents, :license_files,:frame_files,:accident_files, :auction
  
  #DISPLACEMENTS={'','1.2'=>12,'1.5'=>15,'1.6'=>16,'2.4'=>24} #排量
  
  #["待评估车辆"=>0,"待处理车辆"=>1,"委托车辆"=>2,"待提车辆"=>3,"过户车辆"=>4]
  def self.list_by(process_method)
    self.includes("accidents").where("accidents.chuli_fangshi =#{process_method}").all
  end
end
