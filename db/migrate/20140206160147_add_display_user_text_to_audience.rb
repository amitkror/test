class AddDisplayUserTextToAudience < ActiveRecord::Migration
  def change
    add_column :audiences, :display_user_text, :boolean, default: :false
    add_column :audiences, :placeholder_text, :string
    add_column :audiences, :newsletter_id, :integer
  end
end
