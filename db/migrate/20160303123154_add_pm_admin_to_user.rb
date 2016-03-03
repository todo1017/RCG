class AddPmAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :pm_admin, :boolean
  end
end
