class AddLatLonIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :places, :latitude
    add_index :places, :longitude
  end
end
