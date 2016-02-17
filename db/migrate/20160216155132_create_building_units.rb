class CreateBuildingUnits < ActiveRecord::Migration
  def change
    create_table :building_units do |t|
      t.string :number
      t.integer :building_id
      t.integer :unit_type_id
      t.integer :sq_feet
      t.text :resident_name
      t.float :market_rent
      t.float :actual_rent
      t.float :resident_deposit
      t.float :other_deposit
      t.date :move_in
      t.date :move_out
      t.date :lease_expiration
      t.text :notes

      t.timestamps null: false
    end
  end
end
