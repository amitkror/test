class AddNotifyQuestionAssignmentToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :notify_question_assignments, :boolean, default: false
  end
end
