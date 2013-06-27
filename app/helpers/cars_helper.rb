module CarsHelper
  
  
  def car_model_select(car)
    pinpais = CarModel.roots
    selected_pinpai = selected_chexi =  selected_chexing = nil;
    
    if car.present? and !car.new_record?
      self_and_ancestors = car.model.self_and_ancestors
      selected_pinpai = self_and_ancestors[0]
      selected_chexi = self_and_ancestors[1] 
      selected_chexing = self_and_ancestors[2] 
    end
    select_tag_string = "<select id='car_model_pinpai' name='pinpai_id' >"
    for cm in pinpais
      if selected_pinpai == cm
        select_tag_string << "<option value='#{cm.id}' selected='selected'> #{cm.initial}#{cm.name} </option>"       
      else
        select_tag_string << "<option value='#{cm.id}' class=''> #{cm.initial}#{cm.name} </option>"          
      end
    end    
    select_tag_string << "</select>"    
    select_tag_string << "<select id='car_model_chexi' name='chexi_id' >"
    if selected_chexi
      select_tag_string << "<option value='#{selected_chexi.id}' selected='selected' > #{selected_chexi.name} </option>"      
    end
    select_tag_string << "</select>"
    select_tag_string << "<select id='car_model_id' name='car[model_id]' >"     
    if selected_chexing
      select_tag_string << "<option value='#{selected_chexing.id}' selected='selected' > #{selected_chexing.name} </option>"      
    end
    select_tag_string << "</select>"
    
    select_tag_string << "<script type='text/javascript' charset='utf-8'> $(function() {
    $('#car_model_chexi').remoteChained('#car_model_pinpai','#{get_models_cars_path}');
    $('#car_model_id').remoteChained('#car_model_chexi','#{get_models_cars_path}');
    })</script>"
    select_tag_string
  end
  
end
