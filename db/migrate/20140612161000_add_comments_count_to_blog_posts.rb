class AddCommentsCountToBlogPosts < ActiveRecord::Migration
  def up
  	change_table :blog_posts do |t|
      t.column :comments_count, :integer
      t.column :last_commented_at, :timestamp
      t.column :last_commenter_id, :integer
    end
  end
  def down
  	change_table :blog_posts do |t|
      t.remove :comments_count
      t.remove :last_commented_at
      t.remove :last_commenter_id
    end
  end
end
