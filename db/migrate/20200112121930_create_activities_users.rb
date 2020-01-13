class CreateActivitiesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :activities_users do |t|
      t.integer :activity_id
      t.integer :user_id
    end
  end
end
