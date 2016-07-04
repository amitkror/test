class CreateBlogPostTagsTable < ActiveRecord::Migration
  def up
  	create_table :blog_posts_tags do |t|
      t.belongs_to :blog_post
      t.belongs_to :tag
    end
  end

  def down
  	drop_table :blog_posts_tags
  end
end
