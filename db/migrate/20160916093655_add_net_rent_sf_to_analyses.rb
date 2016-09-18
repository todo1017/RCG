class AddNetRentSfToAnalyses < ActiveRecord::Migration
  def change
    add_column :analyses, :net_rent_sf, :float, :null => false, :default => 0.00
  end
end
