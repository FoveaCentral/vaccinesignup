class DropUnusedTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :read_direct_messages
  end
end
