class CarsController < ApplicationController
  skip_before_filter :authenticate
  
  def index
    page = params[:page].to_i>0 ? params[:page] : 1

    @cars = Car.all(:include=>[:auction,:model, :accidents]).paginate(:page => page, :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cars }
    end
  end

end
