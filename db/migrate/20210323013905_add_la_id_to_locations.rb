class AddLaIdToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :la_id, :string
    add_index :locations, :la_id
  end
end
