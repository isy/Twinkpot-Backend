class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_name, :string, :unique => true
    add_column :users, :profile, :text
    add_column :users, :prefectures, :string
    add_column :users, :user_image, :string
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
  end
end
