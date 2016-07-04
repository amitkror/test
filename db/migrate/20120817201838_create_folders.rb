class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.integer :order, default: 0
      t.integer :bookmarks_count, default: 0

      t.timestamps
    end
    add_index :folders, :user_id
  end
end
