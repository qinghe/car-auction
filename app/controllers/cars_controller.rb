#encoding: utf-8
class CarsController < ApplicationController
  skip_before_filter :authenticate
  
  def index
    @title="事故车"
    filters = ["",{}]
    if params[:filters].present?      
      @filters = params[:filters]
      "name = :name and email = :email"
      if @filters[:model_id].present?
        car_model = CarModel.where(:id=>@filters[:model_id]).first        
        if car_model.present?
          filters[0]<< "model_id in (:model_ids)"
          filters[1][:model_ids]= car_model.leaves.collect{|m| m.id }
        end   
      end     
      if @filters[:keyword].present?
        filters[0] << " and " if filters[0].present?
        if @filters[:keyword].to_i>0
          filters[0] << " id=:id " 
          filters[1][:id] = @filters[:keyword].to_i 
        else
          filters[0] << " car_models.name like :model_name " 
          filters[1][:model_name] = "%{@filters[:keyword]}%"           
        end
      end
    end
    
    @cars = Car.scoped.includes([:car_images, :auction,:model, :accident]).where(filters).paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cars }
    end
  end


  def get_models
    
    car_models = CarModel.where(:parent_id=> (params[:pinpai_id]||params[:chexi_id]))
    @car_models = car_models.collect{|cm| [cm.id, cm.name]}
    respond_to do |format|
      format.json { render json: @car_models }
    end
  end
  
  def get_model
    @car = Car.find(params[:id])
  end
  
end
