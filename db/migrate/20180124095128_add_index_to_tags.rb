class AddIndexToTags < ActiveRecord::Migration[5.1]
  def change
    add_index :tags, :name, name: :'tag_name_idx',  length: {name: 50}
  end
end
