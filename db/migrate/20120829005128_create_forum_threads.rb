class CreateForumThreads < ActiveRecord::Migration
  def change
    create_table :forum_threads do |t|
      t.references :forum, null: false
      t.references :user, null: false
      t.string :name, null: false
      t.string :permalink, null: false
      t.integer :status_id, default: 1
      t.text :message
      t.datetime :last_commented_at
      t.references :last_commenter
      t.integer :comments_count, default: 0

      t.timestamps
    end
    add_index :forum_threads, :forum_id
    add_index :forum_threads, :user_id
    add_index :forum_threads, :permalink, unique: true
    add_index :forum_threads, :last_commenter_id
  end
end
