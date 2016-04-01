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
    @car = UsedCar.new(  permitted_used_car_params )
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
    @car = CarAccessory.new( permitted_car_accessory_params )
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
      if @car.update_attributes( permitted_used_car_params )
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
      if @car.update_attributes( permitted_car_accessory_params )
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
      if params.key?(key) && params[key].key?(:uploaded)
        file_class = key.classify.safe_constantize
        if file_class
          @car_file = file_class.new( permitted_car_file_params( key ) )
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
    @car.update_attributes( permitted_resource_params )
    @car.delegated!
    respond_to do |format|
      format.js {
        render "auction_saved"
        }
    end
  end

  def confirm_auction
    @car.update_attributes(  permitted_resource_params )
    respond_to do |format|
      format.js {
        render "auction_saved"
        }
    end
  end

  def abandon
    @car.update_attributes( permitted_resource_params )
    @return_to_path = list_case_cars_by_status_path( Car.statuses[@car.status] )
    @car.abandon_on_auction!
    respond_to do |format|
      format.js { render "abandoned"}
    end
  end

  def abandon2
    @car.update_attributes(  permitted_resource_params )
    @return_to_path = list_case_cars_by_status_path( Car.statuses[@car.status] )
    @car.abandon_on_pick!
    respond_to do |format|
      format.js { render "abandoned2"}
    end
  end

  def abandon3
    @car.update_attributes(  permitted_resource_params )
    @return_to_path = list_case_cars_by_status_path( Car.statuses[@car.status] )
    @car.abandon_on_transfer!
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
    model_title = params[:model_title]

    condition =""
    if serial_no != ""
      condition<< " and " unless condition.empty?
      condition<< "cars.serial_no='#{serial_no}'"
    end
    if model_title != ""
      condition<< " and " unless condition.empty?
      condition<< "(car_models.name like '%#{model_title}%' or cars.model_title like '%#{model_title}%')"
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
    @car = Car.new(  permitted_resource_params )
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
      if @car.update_attributes(  permitted_resource_params )
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

  def permitted_car_accessory_params
    params[:car_accessory].present? ? params.require(:car_accessory).permit! : ActionController::Parameters.new
  end

  def permitted_resource_params
    params[:car].present? ? params.require(:car).permit! : ActionController::Parameters.new
  end

  def permitted_used_car_params
    params[:used_car].present? ? params.require(:used_car).permit! : ActionController::Parameters.new
  end

  def permitted_car_file_params( key )
    params[key].present? ? params.require(key).permit! : ActionController::Parameters.new
  end

end
