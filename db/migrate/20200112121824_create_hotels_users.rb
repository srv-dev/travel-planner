class CreateHotelsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels_users do |t|
      t.integer :hotel_id
      t.integer :user_id
    end
  end
end
