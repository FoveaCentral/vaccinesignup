class CreateProcessedDirectMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :processed_direct_messages do |t|
      t.integer :direct_message_id

      t.timestamps
    end
  end
end
