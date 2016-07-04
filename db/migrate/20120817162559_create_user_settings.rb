class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.references :user
      t.boolean :notify_folder_update
      t.boolean :notify_thread_comments
      t.boolean :notify_resource_comments

      t.timestamps
    end
    add_index :user_settings, :user_id
  end
end
