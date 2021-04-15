class AddLatLonToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :lat, :string
    add_column :locations, :lon, :string
  end
end
