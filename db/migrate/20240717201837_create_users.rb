class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :timezone, null: false, default: "Eastern Time (US & Canada)"

      t.string :phone_number

      t.integer :user_type

      t.belongs_to :region, null: false, foreign_key: true
      t.timestamps
    end
  end
end
