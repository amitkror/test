class AddSummaryToBlogPosts < ActiveRecord::Migration
  def up
  	change_table :blog_posts do |t|
      t.column :tagline, :text
    end
  end
  def down
  	change_table :blog_posts do |t|
      t.remove :tagline
    end
  end
end
