class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.text :body, null: false
      t.boolean :is_active
      t.integer :email_trigger_count, null: false

      t.timestamps
    end
  end
end
