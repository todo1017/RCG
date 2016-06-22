class AddRelevantDatesToBuildingUnit < ActiveRecord::Migration
  def change
    add_column :building_units, :relevant_start_date, :date
    add_column :building_units, :relevant_end_date, :date
  end
end
