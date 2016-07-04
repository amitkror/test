class CreateScholarships < ActiveRecord::Migration
  def change
    create_table :scholarships do |t|
      t.string :name, default: "", null: false
      t.integer :status_id, default: 1, null: false
      t.datetime :end_date, null: false
      t.text :copy, default: ""
      t.text :terms, default: ""
      t.text :meta_description
      t.string :permalink, null: false

      t.timestamps
    end
    add_index :scholarships, :permalink
  end
end
