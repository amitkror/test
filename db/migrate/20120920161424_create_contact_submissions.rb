class CreateContactSubmissions < ActiveRecord::Migration
  def change
    create_table :contact_submissions do |t|
      t.string :title, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
