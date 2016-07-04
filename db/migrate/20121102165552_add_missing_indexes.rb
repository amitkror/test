class AddMissingIndexes < ActiveRecord::Migration
  def up
    add_index :bookmarks, [:resource_id]
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :questions, [:last_commenter_id]
  end

  def down
    remove_index :bookmarks, [:resource_id]
    remove_index :comments, [:commentable_id, :commentable_type]
    remove_index :questions, [:last_commenter_id]
  end
end
