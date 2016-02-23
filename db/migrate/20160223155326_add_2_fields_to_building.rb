class Add2FieldsToBuilding < ActiveRecord::Migration
  def change
    add_column :buildings, :geography_id, :integer
    add_column :buildings, :competitor, :boolean
  end
end
