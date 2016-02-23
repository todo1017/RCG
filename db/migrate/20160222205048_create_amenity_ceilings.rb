class CreateAmenityCeilings < ActiveRecord::Migration
  def change
    create_table :amenity_ceilings do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
