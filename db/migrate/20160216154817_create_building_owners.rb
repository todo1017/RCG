class CreateBuildingOwners < ActiveRecord::Migration
  def change
    create_table :building_owners do |t|
      t.integer :building_id
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
