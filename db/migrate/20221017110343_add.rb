class Add < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :alt_ru, :string
    add_column :blog_posts, :alt_pl, :string
    add_column :blog_posts, :alt_en, :string
  end
end
