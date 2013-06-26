# encoding: utf-8
class Case::CarsController < Case::ApplicationController
  def welcome
    logger.debug "---in welcome--------------------------"
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  # GET /cars
  # GET /cars.json
  def index
    @process_method = params[:process_method].to_i
    @cars = Car.list_by(@process_method, current_user)
    respond_to do |format|
      format.html { render :cart_list}
      format.json { render json: @cars }
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    @car = Car.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @car }
    end
  end

  def evaluate
    @car = Car.find(params[:id])    
    @car.update_attributes!( params[:car] )
    @car.evaluator_id = current_user.id
    @car.to_status!(1)
    respond_to do |format|
      format.js # show.html.erb
    end  
  end

  def new_auction
    @car = Car.find(params[:id])
    @car.update_attributes(params[:car])
    @car.to_status!(2)
    respond_to do |format|
      format.js { render "auction_saved"}
    end 
  end

  def abandon    
    @car = Car.find(params[:id])
    @car.update_attributes(params[:car])
    @return_to_path = case_car_list_path(@car.status)
    @car.to_status!(5)    
    respond_to do |format|
      format.js { render "abandoned"}
    end     
  end

  def show_auction
    @confirm = params[:confirm].to_i
    @car = Car.find(params[:car_id])
    respond_to do |format|
      format.js
    end
  end

  def show_pickup_car
    @confirm = params[:confirm].to_i
    @car = Car.find(params[:car_id])
    respond_to do |format|
      format.js
    end
  end

  def new_car_accident
    @car = Car.new
    respond_to do |format|
      format.html # new.html.erb      
    end
  end

  def upload_car_files
    
  end

  def search
    @process_method = params[:process_method].to_i
    insurance_id = params[:insurance_id]
    serial_no = params[:serial_no]
    model_name = params[:model_name]
    condition = {'cars.status' =>@process_method}
    condition.merge!({'users.company_id'=>insurance_id}) if insurance_id.to_i > 0
    condition.merge!({'cars.serial_no'=>serial_no}) if serial_no != ""
    condition.merge!({'cars.model_name'=>model_name}) if model_name != ""
    @cars = Car.includes(:publisher).where(condition).all
    render 'case/cars/list'
  end

  def list
    @process_method = params[:process_method].to_i
    @cars = Car.list_by(@process_method, current_user)
  end

  # GET /cars/1/edit
  def edit
    @car = Car.find(params[:id])
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(params[:car])
    @car.publisher_id = current_user.id
      if @car.save
        flash_t :success
        redirect_to edit_case_car_url(@car)
      else
        title_t :new
        render :action => :new_car_accident
      end
  end

  # PUT /cars/1
  # PUT /cars/1.json
  def update
    @car = Car.find(params[:id])
    respond_to do |format|
      if @car.update_attributes(params[:car])
        format.html { redirect_to edit_case_car_url, notice=> '更新车辆信息成功！' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car = Car.find(params[:id])
    @car.destroy

    respond_to do |format|
      format.html { redirect_to case_cars_url }
      format.json { head :no_content }
    end
  end
end
