class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :name, null: false
      t.string :mc_template_name
      t.string :mc_template_id
      t.string :mc_list_name
      t.string :mc_list_id
      t.datetime :last_sent_at
      t.text :mc_interest_groups
      t.integer :status_id, null: false, default: 1

      t.timestamps
    end
  end
end
