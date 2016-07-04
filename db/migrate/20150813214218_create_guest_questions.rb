class CreateGuestQuestions < ActiveRecord::Migration
  def change
    create_table :guest_questions do |t|
      t.references :guest_user, null: false
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
    add_index :guest_questions, :guest_user_id
    add_index :guest_questions, :adviser_id
    add_index :guest_questions, :topic_id
  end
end
