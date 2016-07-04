class AddUserToResources < ActiveRecord::Migration
  def change
    add_column :resources, :last_editor_id, :integer
    add_index :resources, :last_editor_id
  end
end
