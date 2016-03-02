class CreateUserGeographies < ActiveRecord::Migration
  def change
    create_table :user_geographies do |t|
      t.integer :user_id
      t.integer :geography_id
      t.string :access_type

      t.timestamps null: false
    end
  end
end
