class CreatePushSubscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :push_subscriptions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :endpoint
      t.string :p256dh_key
      t.string :auth_key
      t.string :user_agent

      t.index [ "endpoint", "p256dh_key", "auth_key" ], name: "idx_on_endpoint_p256dh_key_auth_key_7553014576"


      t.timestamps
    end
  end
end
