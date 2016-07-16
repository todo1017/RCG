class CreateOwnerUsers < ActiveRecord::Migration
  def change
    create_table :owner_users do |t|
      t.integer :owner_id
      t.integer :user_id
      t.boolean :dpm_admin

      t.timestamps null: false
    end
  end
end
