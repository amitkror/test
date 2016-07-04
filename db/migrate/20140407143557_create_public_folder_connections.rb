class CreatePublicFolderConnections < ActiveRecord::Migration
  def change
    create_table :public_folder_connections do |t|
      t.references :folder
      t.references :site_setting
      t.integer :order

      t.timestamps
    end
    add_index :public_folder_connections, :folder_id
  end
end
