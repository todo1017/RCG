class AddConcessionsToBuildingUnit < ActiveRecord::Migration
  def change
    add_column :building_units, :months_off, :integer
    add_column :building_units, :cash_off, :integer
    add_column :building_units, :lease_length, :integer
  end
end
