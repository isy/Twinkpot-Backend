class CreatePostTags < ActiveRecord::Migration[5.1]
  def change
    create_table :post_tags do |t|
      t.integer :post_id, :null => false
      t.integer :tag_id, :null => false
      t.timestamps
    end
  end
end
