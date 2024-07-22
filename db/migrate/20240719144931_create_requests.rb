class CreateRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :requests do |t|
      t.text :access_details
      t.string :location

      t.float :location_lat
      t.float :location_long

      t.datetime :scheduled
      t.datetime :completed

      t.references :customer, null: false
      t.references :vendor
      t.belongs_to :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
