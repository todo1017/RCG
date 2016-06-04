class AddRoomToBuildingUnit < ActiveRecord::Migration
  def change
    add_column :building_units, :add_room, :boolean
  end
end
