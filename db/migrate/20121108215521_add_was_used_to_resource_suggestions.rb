class AddWasUsedToResourceSuggestions < ActiveRecord::Migration
  def change
    add_column :resource_suggestions, :was_used, :boolean, default: false
  end
end
