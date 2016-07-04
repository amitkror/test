class CreatePageAssets < ActiveRecord::Migration
  def change
    create_table :page_assets do |t|
      t.references :page
      t.references :asset
      t.integer :order

      t.timestamps
    end
    add_index :page_assets, :page_id
    add_index :page_assets, :asset_id
  end
end
