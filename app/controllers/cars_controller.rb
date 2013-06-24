#encoding: utf-8
class CarsController < ApplicationController
  skip_before_filter :authenticate
  
  def index
    @title="事故车"
    @cars = Car.all(:include=>[:auction,:model, :accidents]).paginate(:page => params[:page], :per_page => 20)

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
end
