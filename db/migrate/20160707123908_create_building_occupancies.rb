class CreateBuildingOccupancies < ActiveRecord::Migration
  def change
    create_table :building_occupancies do |t|
      t.integer :building_id
      t.float :occupancy_rate
      t.float :leased_rate
      t.date :as_of_date

      t.timestamps null: false
    end
  end
end
