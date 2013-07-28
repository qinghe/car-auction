# encoding: utf-8
class Admin::CarsController < Case::CarsController
  layout "application"
  prepend_before_filter :get_data, :only=>[:show,:evaluate,:confirm_auction, :abandon, :abandon2, :abandon3, :delete_car_file, :show_used,:show_accessory, :edit_used, :edit_accessory]

  # GET /cars
  # GET /cars.json
  def index
    if params[:type] == 'UsedCar'
      used  
    elsif  params[:type] == 'CarAccessory'
      accessory
    else
      accident
    end    
  end

  def accident
    @title="事故车"
    @cars = AccidentCar.includes(:model).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    render :accident
  end
  
  def used
    @title="二手车"
    @cars = UsedCar.includes(:model).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    render :used    
  end
  
  def accessory
    @title="汽车配件"
    @cars = CarAccessory.includes(:model).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    render :accessory
    
  end
  
  # GET /cars/1
  # GET /cars/1.json
  def show
    @title="事故车-详细信息"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @car }
    end
  end
  
  def new_used
    @title="二手车-添加"
    @car = UsedCar.new
  end
  
  def create_used
    @car = UsedCar.new(params[:used_car])
    @car.publisher_id = current_user.id
    @car.evaluator_id = User.evaluator.id
      if @car.save
        flash_t :success
        redirect_to used_admin_cars_url()
      else
        title_t :new_used
        render :action => :new_used
      end
  end
  
  def edit_used
    @title="二手车-编辑"      
  end
  
  def show_used
    @title="二手车-详细信息"  
  end
  
  def new_accessory
    @title="汽车配件-添加"
    @car = CarAccessory.new
  end

  def show_accessory
    @title="汽车配件-详细信息"  
  end
  def edit_accessory
    @title="汽车配件-编辑"      
  end
  
  def create_accessory
    @car = CarAccessory.new(params[:car_accessory])
    @car.publisher_id = current_user.id
    @car.evaluator_id = User.evaluator.id
      if @car.save
        flash_t :success
        redirect_to accessory_admin_cars_url()
      else
        title_t :new_accessory
        render :action => :new_accessory
      end
  end
  def update_used
    @car = UsedCar.find(params[:id])
    respond_to do |format|
      if @car.update_attributes(params[:used_car])
        format.html { redirect_to admin_cars_url(:type=>@car.type), notice=> '更新二手车信息成功！' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_used" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end  
  def update_accessory
    @car = CarAccessory.find(params[:id])
    respond_to do |format|
      if @car.update_attributes(params[:car_accessory])
        format.html { redirect_to admin_cars_url(:type=>@car.type), notice=> '更新配件信息成功！' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_accessory" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
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
      format.js {
        render "auction_saved"
        }
    end 
  end

  def confirm_auction
    @car.update_attributes(params[:car])
    respond_to do |format|
      format.js {
        render "auction_saved"
        }
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
    
  def new_car_accident
    @car = Car.new
    respond_to do |format|
      format.html # new.html.erb      
    end
  end

  def search
    insurance_id = params[:insurance_id]
    serial_no = params[:serial_no]
    model_name = params[:model_name]

    condition =""
    if serial_no != ""
      condition<< " and " unless condition.empty?
      condition<< "cars.serial_no='#{serial_no}'"
    end
    if model_name != ""
      condition<< " and " unless condition.empty?
      condition<< "(car_models.name like '%#{model_name}%' or cars.model_name like '%#{model_name}%')"
    end
    @cars = Car.includes(:publisher,:model).where(condition).all
    render 'admin/cars/index'
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
    @car.evaluator_id = User.evaluator.id
      if @car.save
        flash_t :success
        redirect_to case_car_url(@car)
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
      format.html { redirect_to admin_cars_url(:type=>@car.type), notice=> '车辆删除成功！' }
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
