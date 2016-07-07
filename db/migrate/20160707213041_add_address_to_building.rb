class AddAddressToBuilding < ActiveRecord::Migration
  def change
    add_column :buildings, :address1, :string
    add_column :buildings, :address2, :string
    add_column :buildings, :city, :string
    add_column :buildings, :state, :string
    add_column :buildings, :zip, :string
    add_column :buildings, :owned_by, :string
    add_column :buildings, :managed_by, :string
    add_column :buildings, :end_date, :date
  end
end
