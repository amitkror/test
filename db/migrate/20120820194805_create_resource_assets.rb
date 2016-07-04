class CreateResourceAssets < ActiveRecord::Migration
  def change
    create_table :resource_assets do |t|
      t.references :resource
      t.references :asset
      t.integer :order

      t.timestamps
    end
    add_index :resource_assets, :resource_id
    add_index :resource_assets, :asset_id
  end
end
