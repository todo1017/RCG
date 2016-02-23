class CreateGeographies < ActiveRecord::Migration
  def change
    create_table :geographies do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
