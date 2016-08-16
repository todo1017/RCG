class AddMonthToAnalyses < ActiveRecord::Migration
  def change
    add_column :analyses, :month, :string
  end
end
