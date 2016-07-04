class CreateUserBoroughs < ActiveRecord::Migration
  def change

    add_column :users, :borough_id, :integer
    add_index :users, :borough_id

    add_column :boroughs, :show_in_filters, :boolean, default: true
    add_column :boroughs, :show_in_settings, :boolean, default: true

    b = Borough.find_or_create_by_name({
      name: "I live outside of NYC",
      order: Borough.all.size,
      show_in_filters: false,
      show_in_settings: true
    })
    b.show_in_filters = false
    b.save!
  end
end
