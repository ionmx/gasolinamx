class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.references :place
      t.decimal  :regular, precision: 5, scale: 2
      t.decimal  :premium, precision: 5, scale: 2
      t.decimal  :diesel, precision: 5, scale: 2
      t.datetime :date_add
      t.timestamps
    end
  end
end
