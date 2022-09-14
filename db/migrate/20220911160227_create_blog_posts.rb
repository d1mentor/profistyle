class CreateBlogPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_posts do |t|
      t.string :name_ru
      t.string :title_ru
      t.string :text_ru
      t.string :name_pl
      t.string :title_pl
      t.string :text_pl
      t.string :name_en
      t.string :title_en
      t.string :text_en

      t.timestamps
    end
  end
end
