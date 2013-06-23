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

end
