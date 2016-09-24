class AddOwnedToAnalyses < ActiveRecord::Migration
  def change
    add_column :analyses, :owned, :boolean
  end
end
