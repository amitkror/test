class AddColumnToComments < ActiveRecord::Migration
  def change
    add_column :comments, :guest_user_id, :integer
    add_index :comments, :guest_user_id
  end
end
