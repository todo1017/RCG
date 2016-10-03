class AddOwnerIdToGeography < ActiveRecord::Migration
  def change
    add_column :geographies, :owner_id, :integer
    add_column :comp_groups, :owner_id, :integer
  end
end
