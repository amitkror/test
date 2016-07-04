class CreatePhases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.string :name, null: false
      t.integer :order, default: 0
      t.text :teaser, default: ''
      t.references :page

      t.timestamps
    end
    add_index :phases, :page_id
  end
end
