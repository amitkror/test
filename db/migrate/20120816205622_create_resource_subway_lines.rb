class CreateResourceSubwayLines < ActiveRecord::Migration
  def change
    create_table :resource_subway_lines do |t|
      t.references :resource, null: false
      t.references :subway_line, null: false

      t.timestamps
    end
    add_index :resource_subway_lines, :resource_id
    add_index :resource_subway_lines, :subway_line_id
  end
end
