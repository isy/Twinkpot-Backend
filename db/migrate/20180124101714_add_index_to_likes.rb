class AddIndexToLikes < ActiveRecord::Migration[5.1]
  def change
    add_index :likes, %i(user_id post_id), name: :'like_idx01'
  end
end
