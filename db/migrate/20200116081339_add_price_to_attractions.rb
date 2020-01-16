class AddPriceToAttractions < ActiveRecord::Migration[5.2]
  def change
    add_column :attractions, :price, :float
  end
end
