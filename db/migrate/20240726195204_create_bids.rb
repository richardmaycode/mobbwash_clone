class CreateBids < ActiveRecord::Migration[7.2]
  def change
    create_table :bids do |t|
      t.belongs_to :request, null: false
      t.references :vendor, null: false
      t.float :amount
      t.datetime :work_date

      t.timestamps
    end
  end
end
