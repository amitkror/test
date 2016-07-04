class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.integer :type_id
      t.integer :status_id, default: 1
      t.string :permalink, null: false
      t.integer :resources_count, default: 0

      t.timestamps
    end
    add_index :organizations, :type_id
    add_index :organizations, :permalink, unique: true
  end
end
