class CreateVehicles < ActiveRecord::Migration[7.2]
  def change
    create_table :vehicles do |t|
      t.string :nickname
      t.string :make
      t.string :model
      t.string :color
      t.string :license_plate
      t.boolean :default
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
