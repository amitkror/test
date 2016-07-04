class CreateEventBoroughs < ActiveRecord::Migration
  def change
    create_table :event_boroughs do |t|
      t.references :event
      t.references :borough

      t.timestamps
    end
    add_index :event_boroughs, :event_id
    add_index :event_boroughs, :borough_id
  end
end
