class AddGrossRentToAnalyses < ActiveRecord::Migration
  def change
    add_column :analyses, :gross_rent, :string
  end
end
