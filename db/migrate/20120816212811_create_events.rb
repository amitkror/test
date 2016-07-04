class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime
      t.string :organization
      t.string :website
      t.string :cost_text
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone_number
      t.string :location
      t.string :street
      t.string :city
      t.string :state, default: "NY"
      t.string :postal_code
      t.text :body, null: false
      t.string :logo_uid
      t.string :logo_name
      t.string :attachment_uid
      t.string :attachment_name
      t.string :attachment_label
      t.integer :status_id, default: 1
      t.string :permalink, null: false
      t.float :latitude
      t.float :longitude
      t.datetime :last_commented_at
      t.references :last_commenter
      t.integer :comments_count, default: 0

      t.timestamps
    end
    add_index :events, :status_id
    add_index :events, :permalink, unique: true
    add_index :events, :last_commenter_id
  end
end
