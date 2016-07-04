class AddKeywordsToResources < ActiveRecord::Migration
  def change
    add_column :resources, :keywords, :text, default: ""
  end
end
