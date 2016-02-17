class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.text :name
      t.text :description
      t.integer :comp_group_id
      t.text :phone
      t.text :manager
      t.integer :number_of_units
      t.text :website
      t.integer :year_built
      t.integer :year_remodeled

      t.timestamps null: false
    end
  end
end
