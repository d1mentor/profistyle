class SitemapController < ApplicationController
  def sitemap
    @posts = BlogPost.all
    @blog_updated_at = @posts.last.updated_at
  end
end
