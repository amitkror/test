class CreateForumAudiences < ActiveRecord::Migration
  def change
    create_table :forum_audiences do |t|
      t.references :forum, null: false
      t.references :audience, null: false

      t.timestamps
    end
    add_index :forum_audiences, :forum_id
    add_index :forum_audiences, :audience_id
  end
end
