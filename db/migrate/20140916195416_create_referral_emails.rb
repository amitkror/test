class CreateReferralEmails < ActiveRecord::Migration
  def change
    create_table :referral_emails do |t|
      t.integer :user_id, null: false
      t.string :recipient, null: false
      t.string :subject, null: false
      t.text :message
      t.boolean :cc_me

      t.timestamps
    end
    add_index :referral_emails, :user_id
  end
end
