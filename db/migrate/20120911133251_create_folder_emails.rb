class CreateFolderEmails < ActiveRecord::Migration
  def change
    create_table :folder_emails do |t|
      t.references :folder, null: false
      t.references :user, null: false
      t.string :recipient, null: false
      t.string :subject, null: false
      t.text :message
      t.boolean :cc_me

      t.timestamps
    end
    add_index :folder_emails, :folder_id
    add_index :folder_emails, :user_id
  end
end
