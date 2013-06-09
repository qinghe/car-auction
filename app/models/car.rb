class Car < ActiveRecord::Base
  attr_accessible :engine_number, :frame_number, :is_at, :model_id, :model_name, :plate_number, :registered_at, :serial_no
  has_many :accidents, :dependent => :destroy
  has_many :car_files, :dependent => :destroy
  
  has_many :license_files, :conditions=>{:type=>0}, :class_name =>'CarFile'
  has_many :frame_files, :conditions=>{:type=>1}, :class_name =>'CarFile'
  has_many :accident_files, :conditions=>{:type=>2}, :class_name =>'CarFile'
  
  attr_accessible :accidents_attributes, :license_files_attributes, :frame_files_attributes, :accident_files_attributes  
  accepts_nested_attributes_for :accidents, :license_files,:frame_files,:accident_files
  
  
end
