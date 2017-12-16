class AddColumnPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :place_id, :string
    add_column :posts, :place_name, :string
  end
end
