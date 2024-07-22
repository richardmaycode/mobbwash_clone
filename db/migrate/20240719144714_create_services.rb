class CreateServices < ActiveRecord::Migration[7.2]
  def change
    create_table :services do |t|
      t.string :name
      t.float :price
      t.boolean :active

      t.timestamps
    end
  end
end
