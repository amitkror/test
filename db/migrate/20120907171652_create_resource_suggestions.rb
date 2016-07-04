class CreateResourceSuggestions < ActiveRecord::Migration
  def change
    create_table :resource_suggestions do |t|
      t.references :user, null: false
      t.references :type
      t.string :attachment_uid
      t.string :attachment_name
      t.string :link
      t.string :title
      t.text :description
      t.boolean :accepts_tos

      t.timestamps
    end
    add_index :resource_suggestions, :user_id
    add_index :resource_suggestions, :type_id
  end
end
