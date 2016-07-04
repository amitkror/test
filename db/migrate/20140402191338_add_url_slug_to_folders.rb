class AddUrlSlugToFolders < ActiveRecord::Migration
  def self.up
  	add_column :folders, :slug, :string, :null => true
  end
  def self.down
  	remove_column :folders, :slug
  end
end
