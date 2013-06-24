module CarsHelper
  def car_model_select
    pinpais = CarModel.roots
    select_tag_string = "<select id='car_model_pinpai' name='pinpai_id'>"
    for cm in pinpais
      select_tag_string << "<option value='#{cm.id}' class=''> #{cm.name} </option>"
    end    
    select_tag_string << "</select>"    
    select_tag_string << "<select id='car_model_chexi' name='chexi_id'>"      
    select_tag_string << "</select>"
    select_tag_string << "<select id='car_model_id' name='car[model_id]'>"     
    select_tag_string << "</select>"
    
    select_tag_string << "<script type='text/javascript' charset='utf-8'> $(function() {
    $('#car_model_chexi').remoteChained('#car_model_pinpai','#{get_models_cars_path}');
    $('#car_model_id').remoteChained('#car_model_chexi','#{get_models_cars_path}');
    })</script>"
    select_tag_string
  end
  
  def car_model_select_useless
    pinpais, chexis, chexings = CarModel.get_grouped_models 
    select_tag_string = "<select id='car_model_pinpai' name='car_model[pinpai]'>"
    for cm in pinpais
      select_tag_string << "<option value='m#{cm.id}' class=''> #{cm.name} </option>"
    end    
    select_tag_string << "</select>"
    
    select_tag_string << "<select id='car_model_chexi' name='car_model[chexi]'>"
    for cm in chexis
      select_tag_string << "<option value='m#{cm.id}' class='m#{cm.parent_id}'> #{cm.name} </option>"
    end    
    select_tag_string << "</select>"
    select_tag_string << "<select id='car_model_id' name='car[model_id]'>"
    for cm in chexings
      select_tag_string << "<option value='#{cm.id}' class='m#{cm.parent_id}'> #{cm.name} </option>"
    end    
    select_tag_string << "</select>"
    
    select_tag_string << "<script type='text/javascript' charset='utf-8'> $(function() {
    $('#car_model_chexi').remoteChained('#car_model_pinpai','#{get_models_cars_path}');
    $('#car_model_id').remoteChained('#car_model_chexi','#{get_models_cars_path}');
    })</script>"
    select_tag_string
  end
  
end
