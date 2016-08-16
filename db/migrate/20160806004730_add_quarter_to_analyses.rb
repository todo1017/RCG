class AddQuarterToAnalyses < ActiveRecord::Migration
  def change
    add_column :analyses, :quarter, :string
  end
end
