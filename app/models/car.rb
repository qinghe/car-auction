class Car < ActiveRecord::Base
  attr_accessible :engine_number, :frame_number, :is_at, :model_id, :model_name, :plate_number, :registered_at, :serial_no, :accidents_attributes
  has_many :accidents, :dependent => :destroy
  accepts_nested_attributes_for :accidents
  
end
