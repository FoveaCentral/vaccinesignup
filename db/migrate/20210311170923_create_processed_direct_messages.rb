class CreateProcessedDirectMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :processed_direct_messages do |t|
      t.bigint :direct_message_id, index: true, unique: true

      t.timestamps
    end
  end
end
