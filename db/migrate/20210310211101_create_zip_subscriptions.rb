class CreateZipSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :zip_subscriptions do |t|
      t.integer :user_id
      t.string :zip

      t.timestamps
    end
  end
end
