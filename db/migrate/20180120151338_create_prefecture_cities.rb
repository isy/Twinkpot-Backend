class CreatePrefectureCities < ActiveRecord::Migration[5.1]
  def change
    create_table :prefecture_cities do |t|
      t.integer :code, :null => false
      t.string :prefecture, :null => false
      t.string :city, :null => false
      t.timestamps
    end
  end
end
