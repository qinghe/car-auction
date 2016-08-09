module Case
  class UsersController < BaseController
    def new
      @user = User.new
    end

    def create
      @user = User.new(params[:user])
      @user.role= current_user.role
      if @user.save
        flash_t :success
      else
        title_t :new
      end
      redirect_to case_user_list_url
    end

    def list
      @users = current_user.company.all_members.paginate :per_page => 15, :page => params[:page]
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to edit_case_user_url, notice=> '更新员工信息成功！' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user = User.find(params[:id])
      if @user.update_attribute(:status, params[:status])
        redirect_to case_user_list_url
        flash[:success] = "改变用户 id: #{@user.id} 的状态"
      end
    end
  end
end
