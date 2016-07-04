class AddUserTextToUserAudience < ActiveRecord::Migration
  def change
    add_column :user_audiences, :user_text, :text
  end
end
