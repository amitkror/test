class RemoveColumnsFromQuestions < ActiveRecord::Migration
  def up
    remove_column :questions, :topic_id
    remove_column :questions, :subject
  end

  def down
    add_column :questions, :topic_id, :integer
    add_column :questions, :subject, :string
  end
end
