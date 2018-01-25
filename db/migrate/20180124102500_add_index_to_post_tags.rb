class AddIndexToPostTags < ActiveRecord::Migration[5.1]
  def change
    add_index :post_tags, %i(post_id tag_id), name: :'post_tag_idx01'
  end
end
