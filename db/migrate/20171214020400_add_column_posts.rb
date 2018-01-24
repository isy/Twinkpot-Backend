class AddColumnPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :place_id, :string
    add_column :posts, :place_name, :string
    add_column :posts, :address, :string
    add_column :posts, :country, :string
    add_column :posts, :prefectures, :string
    add_column :posts, :city, :string
    add_column :posts, :postal_code, :string
    add_column :posts, :tel, :string
    add_column :posts, :latitude, :string
    add_column :posts, :longitude, :string
    add_column :posts, :post_image, :string
    add_column :posts, :caption, :text
  end
end
