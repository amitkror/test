class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :from_guest_user, :boolean
  end
end
