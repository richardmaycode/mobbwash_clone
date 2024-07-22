class CreateRequestServices < ActiveRecord::Migration[7.2]
  def change
    create_table :request_services do |t|
      t.belongs_to :request, null: false, foreign_key: true
      t.belongs_to :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
