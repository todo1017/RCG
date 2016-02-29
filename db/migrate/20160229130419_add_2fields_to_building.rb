class Add2fieldsToBuilding < ActiveRecord::Migration
  def change
    add_column :buildings, :manager_email, :text
    add_column :buildings, :manager_phone, :text
  end
end
