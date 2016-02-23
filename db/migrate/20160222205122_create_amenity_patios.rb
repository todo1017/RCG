class CreateAmenityPatios < ActiveRecord::Migration
  def change
    create_table :amenity_patios do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
