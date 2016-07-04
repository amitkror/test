class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name, null: false
      t.string :permalink, null: false
      t.integer :status_id, default: 1
      t.integer :forum_threads_count, default: 0
      t.integer :order, default: 0

      t.timestamps
    end
    add_index :forums, :permalink, unique: true
  end
end
