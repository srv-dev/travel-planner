class CreateAttractionsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :attractions_users do |t|
      t.integer :attraction_id
      t.integer :user_id
    end
  end
end
