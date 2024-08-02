class CreatePrices < ActiveRecord::Migration[7.2]
  def change
    create_table :prices do |t|
      t.integer :amount
      t.integer :status
      t.belongs_to :vehicle_size, null: false, foreign_key: true
      t.belongs_to :service, null: false, foreign_key: true
      t.belongs_to :region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
