class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.string :property
      t.string :sq_feet
      t.string :act_rent
      t.string :months_off
      t.string :cash_off
      t.string :lease_length
      t.string :date

      t.timestamps null: false
    end
  end
end
