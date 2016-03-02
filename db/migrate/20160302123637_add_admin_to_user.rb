class AddAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :super_admin, :boolean
    add_column :users, :owner_admin, :boolean
  end
end
