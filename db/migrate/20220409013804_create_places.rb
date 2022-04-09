class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.integer  :identificator
      t.string   :name
      t.string   :cre_identificator
      t.decimal  :latitude, precision: 10, scale: 6
      t.decimal  :longitude, precision: 10, scale: 6
      t.timestamps
    end
  end
end
