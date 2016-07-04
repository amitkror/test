class CreateSubwayLines < ActiveRecord::Migration
  def change
    create_table :subway_lines do |t|
      t.string :name, null: false
      t.integer :order, default: 0

      t.timestamps
    end
  end
end
