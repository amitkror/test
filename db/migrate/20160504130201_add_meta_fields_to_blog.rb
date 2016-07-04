class AddMetaFieldsToBlog < ActiveRecord::Migration
  def change
  	add_column :blog_posts, :meta_title, :string
  	add_column :blog_posts, :meta_keywords, :string
  	add_column :blog_posts, :meta_description, :string
  	add_column :user_settings, :notify_blog_comments, :boolean  	
  end
end
