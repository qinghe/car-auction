# encoding: utf-8
class Case::CompaniesController < Case::ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new( permitted_resource_params )
    @company.company_type= current_user.company.company_type
    if @company.save
      flash_t :success
    else
      title_t :new
    end
    redirect_to case_company_list_url
  end

  def list
    @companies = current_user.company.self_and_descendants
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    respond_to do |format|
      if @company.update_attributes( permitted_resource_params )
        format.html { redirect_to edit_case_company_url, notice=> '更新部门信息成功！' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to case_company_list_url }
      format.json { head :no_content }
    end
  end

  def permitted_resource_params
    params[:company].present? ? params.require(:company).permit! : ActionController::Parameters.new
  end


end
