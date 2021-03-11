class CreateZipSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :zip_subscriptions do |t|
      t.bigint :user_id, foreign_key: true, unique: true
      t.string :zip, foreign_key: true, index: true

      t.timestamps
    end
  end
end
