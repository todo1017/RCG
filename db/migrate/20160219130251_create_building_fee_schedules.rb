class CreateBuildingFeeSchedules < ActiveRecord::Migration
  def change
    create_table :building_fee_schedules do |t|
      t.integer :building_id
      t.float :parking
      t.text :parking_
      t.float :parking_extra
      t.text :parking_extra_
      t.float :security_deposit
      t.text :security_deposit_
      t.float :amenity_fee
      t.text :amenity_fee_
      t.float :trash_fee
      t.text :trash_fee_
      t.float :pet_deposit
      t.text :pet_deposit_
      t.float :pet_dog
      t.text :pet_dog_
      t.float :pet_cat
      t.text :pet_cat_
      t.float :application_fee
      t.text :application_fee_
      t.integer :minimum_lease
      t.text :minimum_lease_
      t.float :monthly_fees
      t.text :monthly_fees_
      t.float :yearly_fees
      t.text :yearly_fees_

      t.timestamps null: false
    end
  end
end
