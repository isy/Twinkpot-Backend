class AddIndexToItineraries < ActiveRecord::Migration[5.1]
  def change
    add_index :itineraries, %i(user_id), name: :'itineraries_user_idx'
  end
end
