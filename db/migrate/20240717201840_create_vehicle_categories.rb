class CreateVehicleCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :vehicle_categories do |t|
      t.string :name
      t.boolean :active
      t.belongs_to :vehicle_size, null: false, foreign_key: true

      t.timestamps
    end
  end
end
