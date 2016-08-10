#encoding: utf-8
class Admin::BaseController < Panel::BaseController
  layout "application"
  before_filter :admin_check

	def admin_check
		if current_user.role != "administrator"
  			redirect_to root_path
  			flash[:error] = "没有操作权限，请以管理员身份登录。"
		end
	end

end
