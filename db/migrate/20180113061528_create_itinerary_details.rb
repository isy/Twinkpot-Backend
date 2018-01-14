class CreateItineraryDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :itinerary_details do |t|
      t.integer :itinerary_id
      t.text :place_name
      t.string :latitude
      t.string :longitude
      t.timestamps
    end
  end
end
