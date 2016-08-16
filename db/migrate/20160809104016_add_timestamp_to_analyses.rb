class AddTimestampToAnalyses < ActiveRecord::Migration
  def change
    add_column :analyses, :timestamp, :string
  end
end
