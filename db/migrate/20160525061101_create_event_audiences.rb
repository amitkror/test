class CreateEventAudiences < ActiveRecord::Migration
  def change
    create_table :event_audiences do |t|
      t.references :event, null: false
      t.references :audience, null: false

      t.timestamps
    end
    add_index :event_audiences, :event_id
    add_index :event_audiences, :audience_id
  end
end
