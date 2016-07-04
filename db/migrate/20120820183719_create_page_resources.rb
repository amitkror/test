class CreatePageResources < ActiveRecord::Migration
  def change
    create_table :page_resources do |t|
      t.references :page
      t.references :resource
      t.integer :order

      t.timestamps
    end
    add_index :page_resources, :page_id
    add_index :page_resources, :resource_id
  end
end
