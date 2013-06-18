class Case::CarsController < Case::ApplicationController
  def welcome
    
  end
  
  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all

    respond_to do |format|
      format.html # index.html.erb
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

  # GET /cars/new
  # GET /cars/new.json
  def new
    @car = Car.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @car }
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
    process_method = params[:process_method].to_i
    insurance_company_id = params[:insurance_company_id]
    serial_no = params[:serial_no]
    model_name = params[:model_name]
    @cars = Car.includes(:publisher).where('cars.serial_no'=>serial_no, 'cars.model_name'=>model_name,'users.company_id'=>insurance_company_id,'cars.status' =>process_method).all
    render 'case/cars/car_list'
  end

  def car_list
    @process_method = params[:process_method]
    @cars = Car.list_by(@process_method.to_i)
  end

  # GET /cars/1/edit
  def edit
    @car = Car.find(params[:id])
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(params[:car])
      if @car.save
        flash_t :success
        redirect_to case_cars_path
      else
        title_t :new
        render :action => :new
      end
  end

  # PUT /cars/1
  # PUT /cars/1.json
  def update
    @car = Car.find(params[:id])

    respond_to do |format|
      if @car.update_attributes(params[:car])
        format.html { redirect_to case_car_url, notice=> 'ok!' }
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
