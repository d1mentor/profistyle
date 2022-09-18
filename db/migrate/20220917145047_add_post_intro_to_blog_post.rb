class AddPostIntroToBlogPost < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :post_intro, :string
  end
end
