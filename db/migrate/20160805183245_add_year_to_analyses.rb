class AddYearToAnalyses < ActiveRecord::Migration
  def change
    add_column :analyses, :year, :string
  end
end
