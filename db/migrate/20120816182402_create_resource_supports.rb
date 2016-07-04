class CreateResourceSupports < ActiveRecord::Migration
  def change
    create_table :resource_supports do |t|
      t.references :resource
      t.references :support

      t.timestamps
    end
    add_index :resource_supports, :resource_id
    add_index :resource_supports, :support_id
  end
end
