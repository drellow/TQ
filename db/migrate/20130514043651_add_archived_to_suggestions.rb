class AddArchivedToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :archived, :boolean, :default => false
  end
end
