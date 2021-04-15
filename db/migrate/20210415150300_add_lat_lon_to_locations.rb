class AddLatLonToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :lat, :float
    add_column :locations, :lon, :float
  end
end
