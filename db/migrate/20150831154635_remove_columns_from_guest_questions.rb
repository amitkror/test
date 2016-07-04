class RemoveColumnsFromGuestQuestions < ActiveRecord::Migration
  def up
    remove_column :guest_questions, :topic_id
    remove_column :guest_questions, :subject
  end

  def down
    add_column :guest_questions, :topic_id, :integer
    add_column :guest_questions, :subject, :string
  end
end
