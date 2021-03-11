class CreateZipSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :zip_subscriptions do |t|
      t.integer :user_id, index: true, unique: true
      t.string :zip, index: true

      t.timestamps
    end
  end
end
