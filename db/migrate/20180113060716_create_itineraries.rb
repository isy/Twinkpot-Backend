class CreateItineraries < ActiveRecord::Migration[5.1]
  def change
    create_table :itineraries do |t|
      t.integer :user_id, :null => false
      t.text :itinerary_name
      t.timestamps
    end
  end
end
