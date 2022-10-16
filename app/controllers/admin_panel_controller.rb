class AdminPanelController < ApplicationController
  before_action :authenticate_user!

  def home
    render "admin_panel/home"
  end

  def posts
    @posts = BlogPost.all.reverse

    render "admin_panel/blog/all_posts"
  end

  def posts_base
    @posts = BlogPost.all.reverse

    render "admin_panel/blog/posts_base"
  end  

  def new_post
    render "admin_panel/blog/new_post"
  end

  def create_post
    @post = BlogPost.new(post_params)
    @post.save!
    redirect_to "/admin_panel/posts_base"
  end

  def destroy_post
    @post = BlogPost.find_by(id: params[:id])
    @post.destroy
    redirect_to "/admin_panel/posts"
  end  

  def edit_post
    @post = BlogPost.find_by(id: params[:id])
    render "admin_panel/blog/post_edit", post: @post
  end

  def update_post
    @post = BlogPost.find_by(id: params[:id])
    @post.update(post_params)
    @post.save!
    redirect_to "/admin_panel/posts"
  end
  
  def portfolio
    render "admin_panel/portfolio/portfolio"
  end  

  private

  def post_params 
    params.permit(:name_ru, :name_pl, :name_en, :text_ru, :text_pl, :text_en, :metatitle_ru, :metatitle_pl, :metatitle_en, :metadescription_ru, :metadescription_pl, :metadescription_en, :post_intro)
  end  
end
