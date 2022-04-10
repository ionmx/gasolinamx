class AddLastToPlaces < ActiveRecord::Migration[7.0]
  def change
    add_column :places, :last_regular, :decimal, precision: 5, scale: 2
    add_column :places, :last_premium, :decimal, precision: 5, scale: 2
    add_column :places, :last_diesel, :decimal, precision: 5, scale: 2
    add_column :places, :date_update, :datetime
  end
end
