class CreateHomeSlides < ActiveRecord::Migration
  def change
    create_table :home_slides do |t|
      t.string :image_uid
      t.string :image_name
      t.integer :order
      t.string :url
      t.references :page
      t.references :site_setting

      t.timestamps
    end
    add_index :home_slides, :page_id
    add_index :home_slides, :site_setting_id
  end
end
