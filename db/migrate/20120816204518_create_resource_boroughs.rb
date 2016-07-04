class CreateResourceBoroughs < ActiveRecord::Migration
  def change
    create_table :resource_boroughs do |t|
      t.references :resource
      t.references :borough

      t.timestamps
    end
    add_index :resource_boroughs, :resource_id
    add_index :resource_boroughs, :borough_id
  end
end
