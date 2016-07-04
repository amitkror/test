class ChangeStatusToStatusIdOnBlogPosts < ActiveRecord::Migration
  def up
  	rename_column :blog_posts, :status, :status_id
  end
  def down
  	rename_column :blog_posts, :status_id, :status
  end
end
