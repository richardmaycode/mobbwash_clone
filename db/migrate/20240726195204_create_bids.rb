class CreateBids < ActiveRecord::Migration[7.2]
  def change
    create_table :bids do |t|
      t.integer :status
      t.float :amount

      t.datetime :work_date
      t.datetime :last_status_update

      t.belongs_to :request, null: false
      t.references :vendor, null: false

      t.timestamps
    end
  end
end
