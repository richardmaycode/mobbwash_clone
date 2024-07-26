class CreateServices < ActiveRecord::Migration[7.2]
  def change
    create_table :services do |t|
      t.string :name
      t.float :min_price
      t.float :max_price
      t.float :avg_price
      t.boolean :active

      t.timestamps
    end
  end
end
