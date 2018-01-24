class CreatePrefectureCities < ActiveRecord::Migration[5.1]
  def change
    create_table :prefecture_cities do |t|
      t.integer :code
      t.string :prefecture
      t.string :city
      t.timestamps
    end
  end
end
