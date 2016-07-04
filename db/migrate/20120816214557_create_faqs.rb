class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :question, null: false
      t.text :answer, null: false
      t.integer :status_id, default: 1

      t.timestamps
    end
    add_index :faqs, :status_id
  end
end
