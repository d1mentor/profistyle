class AddMetadataToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :metadescription_ru, :string
    add_column :blog_posts, :metatitle_ru, :string
    add_column :blog_posts, :metadescription_pl, :string
    add_column :blog_posts, :metatitle_pl, :string
    add_column :blog_posts, :metadescription_en, :string
    add_column :blog_posts, :metatitle_en, :string
  end
end
