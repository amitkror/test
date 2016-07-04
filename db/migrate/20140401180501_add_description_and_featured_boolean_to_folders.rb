class AddDescriptionAndFeaturedBooleanToFolders < ActiveRecord::Migration
  def self.up
  	add_column :folders, :is_featured, :boolean, default: false
  	add_column :folders, :description, :text, null: true
  end
  def self.down
  	remove_column :folders, :is_featured
  	remove_column :folders, :description
  end
end
