class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.text :name
      t.text :description
      t.boolean :competitor

      t.timestamps null: false
    end
  end
end
