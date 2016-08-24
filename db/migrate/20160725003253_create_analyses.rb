class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.integer :building_unit
      t.datetime :date

      t.string  :property
      t.string  :year
      t.string  :quarter
      t.string  :month
      t.float   :gross_rent, :null => false, :default => 0.00
      t.float   :net_rent, :null => false, :default => 0.00
      t.integer :timestamp

      t.timestamps null: false
    end
  end
end
