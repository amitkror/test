class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user, null: false
      t.references :adviser
      t.references :topic
      t.string :subject
      t.text :question
      t.boolean :answered, default: false
      t.boolean :accepts_tos, default: true
      t.boolean :new_comment_for_user, default: false
      t.boolean :new_for_adviser, default: false
      t.boolean :new_comment_for_adviser, default: false
      # commentable fields
      t.datetime :last_commented_at
      t.references :last_commenter
      t.integer :comments_count, default: 0

      t.timestamps
    end
    add_index :questions, :user_id
    add_index :questions, :adviser_id
    add_index :questions, :topic_id
  end
end
