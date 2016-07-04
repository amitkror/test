class CreateGalleryAssets < ActiveRecord::Migration
  def change
    create_table :gallery_assets do |t|
      t.references :gallery, null: false
      t.references :asset, null: false
      t.integer :order, default: 0

      t.timestamps
    end
    add_index :gallery_assets, :gallery_id
    add_index :gallery_assets, :asset_id
  end
end
