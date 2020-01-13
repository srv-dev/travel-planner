class AddDestinationIdToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :destination_id, :integer
  end
end
