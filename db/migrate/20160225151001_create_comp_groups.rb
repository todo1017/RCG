class CreateCompGroups < ActiveRecord::Migration
  def change
    create_table :comp_groups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
