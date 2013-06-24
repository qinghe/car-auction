class CarModel < ActiveRecord::Base
  acts_as_nested_set  
  attr_accessible :initial, :name
  
  def self.get_grouped_models
    car_models = CarModel.all   
    pinpais, pinpai_ids, chexis , chexings=[],[],[],[]   
    for cm in car_models
      if cm.root?
        pinpais.push cm
        pinpai_ids.push cm.id 
      elsif pinpai_ids.include?( cm.parent_id)
        chexis.push cm
      else
        chexings.push cm
      end         
    end
    [pinpais, chexis, chexings]   
  end
  
  def group_name
    "#{self.parent.name}-#{self.initial}-#{self.name}"
  end
  
  
end
