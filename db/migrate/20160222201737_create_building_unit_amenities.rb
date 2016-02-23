class CreateBuildingUnitAmenities < ActiveRecord::Migration
  def change
    create_table :building_unit_amenities do |t|
      t.integer :building_id
      t.boolean :washer_dryer
      t.text :washer_dryer_
      t.boolean :microwave
      t.text :microwave_
      t.boolean :security_alarm
      t.text :security_alarm_
      t.integer :amenity_ceiling_id
      t.text :ceiling_
      t.integer :amenity_patio_id
      t.text :patio_
      t.boolean :oversized_windows
      t.text :oversized_windows_
      t.text :other
      t.text :other_

      t.timestamps null: false
    end
  end
end
