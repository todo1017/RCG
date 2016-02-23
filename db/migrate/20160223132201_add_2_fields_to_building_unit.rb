class Add2FieldsToBuildingUnit < ActiveRecord::Migration
  def change
    add_column :building_units, :resident_id, :string
    add_column :building_units, :floor, :integer
  end
end
