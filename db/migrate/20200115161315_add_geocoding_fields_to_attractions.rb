class AddGeocodingFieldsToAttractions < ActiveRecord::Migration[5.2]
  def change
    add_column :attractions, :address, :text
    add_column :attractions, :latitude, :float
    add_column :attractions, :longitude, :float
  end
end
