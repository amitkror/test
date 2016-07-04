class CreatePromoInstances < ActiveRecord::Migration
  def change
    create_table :promo_instances do |t|
      t.boolean :is_locked, default: false
      t.string :title, null: false
      t.string :link, default: ''
      t.text :copy, default: ''
      t.datetime :publish_date
      t.datetime :unpublish_date
      t.references :promo
      t.references :page
      t.string :image_uid
      t.string :image_name

      t.timestamps
    end
    add_index :promo_instances, :promo_id
    add_index :promo_instances, :page_id
  end
end
