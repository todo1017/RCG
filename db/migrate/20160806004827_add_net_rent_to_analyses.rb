class AddNetRentToAnalyses < ActiveRecord::Migration
  def change
    add_column :analyses, :net_rent, :string
  end
end
