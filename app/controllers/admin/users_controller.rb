#encoding: utf-8
#require 'mail'
class Admin::UsersController < Admin::ApplicationController
	before_filter :admin_user
	
	def index
		@title = "管理平台 :  用户"
		@users = User.find(:all, :conditions => ["role NOT IN (?)", "administrator"], :order => "lastname").paginate :per_page => 15, :page => params[:page]	    	
	end

  def new
  end

  def create
    company = params[:user].delete("company")
    @company = Company.new(company)
    if @company.save
      deposit = params[:user].delete("deposit")
      @useradmin = @company.members.build(params[:user])
      @useradmin.deposit = deposit
      if @useradmin.save
        redirect_to admin_users_path
      else
        render :action => :new
      end
    else
      render :action => :new
    end
  end

	def edit
    @title = "管理平台 :  用户"
    @useradmin = User.find(params[:id])
  end
    
  def update
    @useradmin = User.find(params[:id])
    if params[:user][:password] == ''
      @title = "Edit user"
      flash[:error] = "密码不能为空"
      render :action => :edit
    elsif @useradmin.update_attributes(params[:user])
      redirect_to :action => :index
      flash[:success] = "您的信息修改成功"
    else
      @title = "Edit user"
      render :action => :edit
    end
  end
	
	def points
		@user = User.find(params[:id])
		@pointssum = Bonuspoint.find_all_by_user_id(params[:id])
		@points = Bonuspoint.find_all_by_user_id(params[:id]).paginate :per_page => 15, :page => params[:page]
		@title = "管理平台 :  用户点 #{@user}"
		
		@suma = 0
      	@pointssum.each do |sum|
      		@suma += sum.points
        end
	end
	
	def editpoints
		@title = "管理平台 :  punkty"
		@value = params[:addorremove][:points]
		if @value != ""
		Bonuspoint.use!(params[:addorremove][:points], params[:id], 3)
		flash[:success] = "Dodano #{params[:addorremove][:points]} punkty"
		redirect_to :action => :points
		else
		redirect_to :action => :points
		end
	end
	
	def destroy
		@title = "管理平台 :  用户"
    	@user = User.find_by_id(params[:id])
    	if @user.update_attribute(:status, params[:status])
    		redirect_to "/admin/users"
    		flash[:success] = "改变用户 id: #{@user.id} 的状态"
    	end
    end
    
    def blogposts
    	@title = "管理平台 : 文章"
    	
    	if params[:is_admin].present?  	  
        @blogposts = Blogpost.find_all_by_admin(params[:is_admin].to_i).paginate :per_page => 15, :page => params[:page]    	  
    	else
        @blogposts = Blogpost.all.paginate :per_page => 15, :page => params[:page]    	  
    	end
    end

    def blogpostnew

      @title = "管理平台 : 文章"
      @blogpost = Blogpost.new
    end

    def blogpostnew2
      @blogpost  = current_user.blogposts.build(params[:blogpost])
      @blogpost.admin = true
      #validate_recap(params, @blogpost.errors)
      if @blogpost.save
        flash[:success] = "Blogpost created!"
        redirect_to :action => :blogposts
      else
        render :blogpostnew
      end
    end
    
    def blogpostedit
    	@title = "管理平台 : 文章 || 编辑"
    	@blogpost = Blogpost.find(params[:id])
    	@title = "编辑文章 id: #{@blogpost.id}"
    end
    
    def blogpostedit2
    	@title = "管理平台 : 文章"
    	@blogpost = Blogpost.find(params[:id])
    	@blogpost.update_attributes(params[:blogpost])
    	flash[:success] = "成功修改"
    	redirect_to :action => :blogposts
    end
    
    def deleteblogpost
    	@title = "管理平台 : 文章"
    	@blogpost = Blogpost.find(params[:blogpost])
    	@blogpost.destroy
    	redirect_to :action => :blogposts
    	flash[:success] = "成功删除: #{@blogpost.title}"
    end
    
    def blogpostok
    	@blogpost = Blogpost.find(params[:id])
  		if @blogpost.update_attribute(:admin, 0)
  			flash[:success] = "Post Removed from the list"
  			redirect_to :action => :blogposts
  		else
  			flash[:error] = "There is something super-serious error!"
  			redirect_to :action => :blogposts
  		end
    end
    
    def blogcomments
    	@title = "管理平台 :  评论"
    	@blogcomments = Blogcomment.find_all_by_admin(1).paginate :per_page => 15, :page => params[:page]
    end
    
    def deleteblogcomment
    	@title = "管理平台 :  评论"
    	@blogcomment = Blogcomment.find(params[:blogcomment])
    	@blogcomment.destroy
    	redirect_to :action => :blogcomments
    	flash[:success] = "Usunieto komentarz o id: #{@blogcomment.id}"
    end
    
    def blogcommentok
    	@blogcomment = Blogcomment.find(params[:id])
  		if @blogcomment.update_attribute(:admin, 0)
  			flash[:success] = "Usunieto komentarz z listy"
  			redirect_to :action => :blogcomments
  		else
  			flash[:error] = "There is something super-serious error!"
  			redirect_to :action => :blogcomments
  		end
    end
    
    private
    
    def admin_user
    	if current_user.status != 2
    		redirect_to root_path
    	end
    end

end
