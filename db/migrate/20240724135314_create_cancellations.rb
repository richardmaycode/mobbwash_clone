class CreateCancellations < ActiveRecord::Migration[7.2]
  def change
    create_table :cancellations do |t|
      t.references :vendor
      t.belongs_to :request, null: false, foreign_key: true
      t.datetime :reported
      t.text :notes

      t.timestamps
    end
  end
end
