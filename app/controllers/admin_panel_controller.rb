class AdminPanelController < ApplicationController
  before_action :authenticate_user!

  def home
    render "admin_panel/_sidebar"
  end

  def posts
    @posts = BlogPost.all

    render "admin_panel/blog/all_posts"
  end

  def new_post
    render "admin_panel/blog/new_post"
  end

  def create_post
    @post = BlogPost.new(post_params)
    @post.save!
    redirect_to "/admin_panel/posts"
  end

  def destroy_post
  end  

  def show_post
    render "admin_panel/blog/show_post"
  end
  
  def portfolio
    render "admin_panel/portfolio/portfolio"
  end  

  private

  def post_params 
    params.permit(:name_ru, :name_pl, :name_en, :text_ru, :text_pl, :text_en)
  end  
end
