class CreateUserResources < ActiveRecord::Migration
  def change
    create_table :user_resources do |t|
      t.references :user
      t.references :resource

      t.timestamps
    end
    add_index :user_resources, :user_id
    add_index :user_resources, :resource_id
  end
end
