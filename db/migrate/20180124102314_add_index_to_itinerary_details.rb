class AddIndexToItineraryDetails < ActiveRecord::Migration[5.1]
  def change
    add_index :itinerary_details, %i(itinerary_id), name: :'itinerary_id_idx'
  end
end
