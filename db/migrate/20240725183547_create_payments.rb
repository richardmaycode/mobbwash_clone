class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :outcome
      t.string :memo

      t.timestamps
    end
  end
end
