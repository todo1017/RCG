class CreateBuildingAmenities < ActiveRecord::Migration
  def change
    create_table :building_amenities do |t|
      t.integer :building_id
      t.boolean :business_center
      t.text :business_center_
      t.boolean :resident_lounge
      t.text :resident_lounge_
      t.boolean :screening_room
      t.text :screening_room_
      t.boolean :rooftop_deck
      t.text :rooftop_deck_
      t.boolean :train_station
      t.text :train_station_
      t.boolean :pool
      t.text :pool_
      t.boolean :gated
      t.text :gated_
      t.integer :amenity_concierge_id
      t.text :concierge_
      t.boolean :recreation
      t.text :recreation_
      t.boolean :fitness
      t.text :fitness_
      t.text :other
      t.boolean :amenity_1
      t.text :amenity_1_
      t.string :amenity_1_name
      t.boolean :amenity_2
      t.text :amenity_2_
      t.string :amenity_2_name
      t.boolean :amenity_3
      t.text :amenity_3_
      t.string :amenity_3_name
      t.integer :amenity_11_id
      t.text :amenity_11_
      t.string :amenity_11_name
      t.integer :amenity_12_id
      t.text :amenity_12_
      t.string :amenity_12_name

      t.timestamps null: false
    end
  end
end
