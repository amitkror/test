class CreateResourceAudiences < ActiveRecord::Migration
  def change
    create_table :resource_audiences do |t|
      t.references :resource, null: false
      t.references :audience, null: false

      t.timestamps
    end
    add_index :resource_audiences, :resource_id
    add_index :resource_audiences, :audience_id
  end
end
