class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :title, default: ''
      t.string :alt, default: ''
      t.references :page
      t.string :link
      t.string :attachment_uid, null: false
      t.string :attachment_name, null: false
      t.boolean :is_image, default: false

      t.timestamps
    end
    add_index :assets, :page_id
  end
end
