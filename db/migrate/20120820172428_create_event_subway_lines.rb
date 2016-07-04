class CreateEventSubwayLines < ActiveRecord::Migration
  def change
    create_table :event_subway_lines do |t|
      t.references :event
      t.references :subway_line

      t.timestamps
    end
    add_index :event_subway_lines, :event_id
    add_index :event_subway_lines, :subway_line_id
  end
end
