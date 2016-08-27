class AddAsOfToBuildingUnit < ActiveRecord::Migration
  def change
    add_column :building_units, :as_of_date, :date
    add_column :building_units, :lease_end_date, :date
  end
end
