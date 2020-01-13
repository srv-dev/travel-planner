class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.text :name
      t.text :image
      t.float :price

      t.timestamps
    end
  end
end
