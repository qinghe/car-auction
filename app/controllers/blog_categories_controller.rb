class BlogCategoriesController < ApplicationController
  
  skip_before_filter :authenticate
    
  def show
    @blog_category = BlogCategory.find(params[:id])
    @categories = @blog_category.root.leaves.includes(:blogposts)
    @current_blogpost = @categories.first.blogposts.first  
    @title = "#{@blog_category.name}"
  end
  
  def blogpostshow    
    @current_blogpost = Blogpost.find( params[:id] )
    @blog_category = @current_blogpost.category
    @categories = @blog_category.root.leaves.includes(:blogposts)
    @title = "#{@blog_category.name}"

    render :show    
  end
  
    
end
