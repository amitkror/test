class CreateBlogPostAudiences < ActiveRecord::Migration
  def change
    create_table :blog_post_audiences do |t|

      t.references :blog_post, null: false
      t.references :audience, null: false

      t.timestamps
    end
    add_index :blog_post_audiences, :blog_post_id
    add_index :blog_post_audiences, :audience_id
  end
end
