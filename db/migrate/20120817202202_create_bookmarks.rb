class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false
      t.references :folder, null: false
      t.references :resource, null: false
      t.integer :order, default: 0

      t.timestamps
    end
    add_index :bookmarks, :user_id
    add_index :bookmarks, :folder_id
  end
end
