class CreateRegions < ActiveRecord::Migration[7.2]
  def change
    create_table :regions do |t|
      t.string :name
      t.boolean :active
      t.float :center_lat
      t.float :center_long

      t.timestamps
    end
  end
end
