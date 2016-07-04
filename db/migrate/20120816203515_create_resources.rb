class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.integer :type_id, null: false
      t.integer :bookmarks_count, default: 0
      t.integer :helpful_count, default: 1
      t.references :organization
      t.string :website
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone_number
      t.string :street
      t.string :city
      t.string :state, default: "NY"
      t.string :postal_code
      t.text :when_text
      t.string :cost_text
      t.string :size_text
      t.boolean :is_experts_pick
      t.references :conditions_of_use
      t.text :body
      t.text :teaser, default: ''
      t.string :logo_uid
      t.string :logo_name
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
    add_index :resources, :type_id
    add_index :resources, :organization_id
    add_index :resources, :conditions_of_use_id
    add_index :resources, :status_id
    add_index :resources, :permalink, unique: true
    add_index :resources, :last_commenter_id
  end
end
