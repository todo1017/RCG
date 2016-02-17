class CreateUnitTypes < ActiveRecord::Migration
  def change
    create_table :unit_types do |t|
      t.text :description
      t.integer :beds
      t.integer :baths
      t.integer :sq_ft_low
      t.integer :sq_ft_high
      t.integer :floor_low
      t.integer :floor_high

      t.timestamps null: false
    end
  end
end
