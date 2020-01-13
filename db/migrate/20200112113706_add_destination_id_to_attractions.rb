class AddDestinationIdToAttractions < ActiveRecord::Migration[5.2]
  def change
    add_column :attractions, :destination_id, :integer
  end
end
