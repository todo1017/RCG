class CreateUserBuildings < ActiveRecord::Migration
  def change
    create_table :user_buildings do |t|
      t.integer :user_id
      t.integer :building_id

      t.timestamps null: false
    end
  end
end
