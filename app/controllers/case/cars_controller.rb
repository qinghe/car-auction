class Case::CarsController < Case::ApplicationController
  prepend_before_filter :get_data, :only=>[:edit, :show,:evaluate,:sendback,:new_auction,:feedback_auction, :confirm_auction, :abandon,:pickup, :abandon2, :abandon3, :transfer, :delete_car_file, :confirm_transfer]

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
    # may auction it again, let user decide, if there are offers, select the heighest one
    if @car.delegated?
      if @car.auction.closed? && @car.auction.offers.present?
        @car.auction.close!
      end
    end

    @car.build_auction  if @car.auction.blank?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @car }
    end
  end

  def sendback
    unless @car.wait_for_evaluate?
      if @car.evaluated?
        @car.wait_for_evaluate!
      elsif @car.delegated?
         @car.evaluated!
      end
      #@car.to_status!(@car.status-1)
    end
    redirect_to case_car_url(@car)
  end

  def evaluate
    @car.update_attributes!( permitted_params )

    ActiveSupport::Notifications.instrument( 'dlhc.car.evaluated', { car: @car} ) do
      @car.evaluator_id = current_user.id
      @car.evaluated!
      if @car.publisher_pingan_pusher?
        Pingan::QuotedPriceMessage.new( @car.auction ).post
      end
    end

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
    @car.update_attributes( permitted_params )
    @car.delegated!
    respond_to do |format|
      format.js {
        render "auction_saved"
        }
    end
  end

  def feedback_auction
    @car.update_attributes( permitted_params )

    if @car.publisher_pingan_pusher?
      Pingan::AuctionResultMessage.new( @car.auction ).post
    end

    respond_to do |format|
      format.js {
        render "auction_saved"
      }
    end
  end

  def confirm_auction
    @car.update_attributes( permitted_params )
    respond_to do |format|
      format.js {
        render "auction_saved"
        }
    end
  end

  def abandon
    @car.update_attributes( permitted_params )
    @return_to_path = case_car_list_path(@car.status)
    @car.abandon_on_auction!
    respond_to do |format|
      format.js { render "abandoned"}
    end
  end

  def pickup
    @car.update_attributes( permitted_params )
    @return_to_path = case_car_path(@car)
    @car.wait_for_pick!
    respond_to do |format|
      format.js { render "pickuped"}
    end
  end
  def abandon2
    @car.update_attributes( permitted_params )
    @return_to_path = case_car_list_path(@car.status)
    @car.abandon_on_pick!
    respond_to do |format|
      format.js { render "abandoned2"}
    end
  end

  def abandon3
    @car.update_attributes( permitted_params )
    @return_to_path = case_car_list_path(@car.status)
    @car.abandon_on_transfer!
    respond_to do |format|
      format.js { render "abandoned3"}
    end
  end

  def confirm_transfer
    @car.update_attributes( permitted_params )

    ActiveSupport::Notifications.instrument( 'dlhc.car.transferred', { car: @car} ) do
      @car.transferred!
      if @car.publisher_pingan_pusher?
        Pingan::TransferInfoMessage.new( @car.auction ).post
      end
    end

    respond_to do |format|
      format.js {
        render "auction_saved"
        }
    end
  end

  def new_car_accident
    @car = AccidentCar.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def search
    insurance_id = params[:insurance_id]
    serial_no = params[:serial_no]
    model_title = params[:model_title]

    condition ="cars.publisher_id=#{current_user.id}"
    if insurance_id.to_i > 0
      condition+=" and users.company_id=#{insurance_id}"
    end
    if serial_no != ""
      condition+=" and cars.serial_no='#{serial_no}'"
    end
    if model_title != ""
      condition+=" and (car_models.name like '%#{model_title}%' or cars.model_title like '%#{model_title}%')"
    end
    @cars = Car.includes(:publisher,:model).where(condition).all
    render 'case/cars/list'
  end

  def list
    @process_method = params[:process_method].to_i
    @cars = Car.list_by(@process_method, current_user).includes(:model).order('created_at DESC')
  end

  # GET /cars/1/edit
  def edit

  end
  # POST /cars
  # POST /cars.json
  def create
    @car = AccidentCar.new( permitted_params )
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
      if @car.update_attributes( permitted_params )
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
      format.html { redirect_to case_car_list_path(@car.status) }
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

    @car = AccidentCar.find(params[:id])
  end

  def permitted_params
    params.require( :accident_car ).permit!
  end
end
