class AddBedbathsToBuildingUnit < ActiveRecord::Migration
  def change
    add_column :building_units, :bed_bath, :string
    add_column :building_units, :beds, :integer
    add_column :building_units, :baths, :float
  end
end
