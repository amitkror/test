class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :permalink
      t.text :body
      t.references :user
      t.integer :status

      t.string :image_uid
      t.string :image_name

      t.timestamps
    end
    add_index :blog_posts, :user_id
  end
end
