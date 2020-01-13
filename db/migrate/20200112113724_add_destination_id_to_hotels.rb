class AddDestinationIdToHotels < ActiveRecord::Migration[5.2]
  def change
    add_column :hotels, :destination_id, :integer
  end
end
