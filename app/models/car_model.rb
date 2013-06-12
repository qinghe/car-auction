class CarModel < ActiveRecord::Base
  acts_as_nested_set  
  attr_accessible :initial, :name
  
  
  def group_name
    "#{self.parent.name}-#{self.initial}-#{self.name}"
  end
end
