# encoding: utf-8
class Case::CarsController < Case::ApplicationController
  prepend_before_filter :get_data, :only=>[:show,:evaluate,:sendback,:new_auction, :abandon,:pickup, :abandon2, :abandon3, :transfer, :delete_car_file]

  def welcome
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  # GET /cars
  # GET /cars.json
  def index
    @process_method = params[:process_method].to_i
    @cars = Car.list_by(@process_method, current_user).includes(:model).order('created_at DESC')
    respond_to do |format|
      format.html { render :list}
      format.json { render json: @cars }
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    if @car.status? 2
      if @car.auction.closed? and @car.auction.won_offer.blank?
        @car.auction.close!
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @car }
    end
  end
  
  def sendback
    if @car.status>0
      @car.to_status!(@car.status-1)
    end
    redirect_to case_car_url(@car)
  end
  
  def evaluate
    @car.update_attributes!( params[:car] )
      @car.evaluator_id = current_user.id
      @car.to_status!(1)
    respond_to do |format|
      format.js # show.html.erb
    end  
  end

  def upload_file
    @car_file = nil
    ['car_doc','car_image', 'car_frame_image', 'car_license_image'].each{|key|
      if params.key?(key) and params[key].key?(:uploaded)
        file_class = key.classify.safe_constantize
        if file_class
          @car_file = file_class.new(params[key])
          @car_file.user_id = current_user.id
        end
      end
    }
      if @car_file.save
        render :text=> {:files=> [@car_file.to_jq_upload]}.to_json, :status=> :created, :location=> @car_file.uploaded.url 
      else
        render :text=> @car_file.errors, :status=> :unprocessable_entity 
      end
  end
  
  def delete_file
    @deleted_file = CarFile.find(params[:file_id])
    @deleted_file.delete
    #@files = file.type.constantize.where(["user_id=? and car_id=?",current_user.id, file.car_id ])
    respond_to do |format|
      format.js { render "file_deleted"}
    end    
  end
  
 
  def new_auction
    @car.update_attributes(params[:car])
    @car.to_status!(2)
    respond_to do |format|
      format.js { render "auction_saved"}
    end 
  end

  def abandon    
    @car.update_attributes(params[:car])
    @return_to_path = case_car_list_path(@car.status)
    @car.to_status!(5)    
    respond_to do |format|
      format.js { render "abandoned"}
    end     
  end

  def pickup
    @car.update_attributes(params[:car])
    @return_to_path = case_car_path(@car)
    @car.to_status!(3)   
    respond_to do |format|
      format.js { render "pickuped"}
    end
  end
  def abandon2
    @car.update_attributes(params[:car])
    @return_to_path = case_car_list_path(@car.status)
    @car.to_status!(6)   
    respond_to do |format|
      format.js { render "abandoned2"}
    end
  end
  
  def abandon3
    @car.update_attributes(params[:car])
    @return_to_path = case_car_list_path(@car.status)
    @car.to_status!(7)   
    respond_to do |format|
      format.js { render "abandoned3"}
    end
  end
  
  def transfer
    @car.to_status!(4)
    redirect_to case_car_list_path(@car.status)
  end
  
  def new_car_accident
    @car = Car.new
    respond_to do |format|
      format.html # new.html.erb      
    end
  end

  def search
    @process_method = params[:process_method].to_i
    insurance_id = params[:insurance_id]
    serial_no = params[:serial_no]
    model_name = params[:model_name]

    condition ="cars.status=#{@process_method} and cars.publisher_id=#{current_user.id}"
    condition_values = []
    if insurance_id.to_i > 0
      condition+=" and users.company_id=?"
      condition_values << insurance_id
    end
    if serial_no != ""
      condition+=" and cars.serial_no=?"
      condition_values << serial_no
    end
    if model_name != ""
      condition+=" and (car_models.name=? or cars.model_name=?)"
      condition_values += [model_name,model_name]
    end
    @cars = Car.includes(:publisher,:model).where([condition]+condition_values).all
    render 'case/cars/list'
  end

  def list
    @process_method = params[:process_method].to_i
    @cars = Car.list_by(@process_method, current_user).includes(:model).order('created_at DESC')
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
  private
  def get_data      
    unless Car.exists? params[:id]
      flash_t_general :error, 'car.dont_exists'
      redirect_to case_cars_path
      return
    end
        
    @car = Car.find(params[:id])
  end
  
end
