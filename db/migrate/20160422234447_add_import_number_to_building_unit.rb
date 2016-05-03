class AddImportNumberToBuildingUnit < ActiveRecord::Migration
  def change
    add_column :building_units, :import_number, :integer
  end
end
