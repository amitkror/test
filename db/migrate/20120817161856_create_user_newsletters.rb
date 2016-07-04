class CreateUserNewsletters < ActiveRecord::Migration
  def change
    create_table :user_newsletters do |t|
      t.references :user
      t.references :newsletter

      t.timestamps
    end
    add_index :user_newsletters, :user_id
    add_index :user_newsletters, :newsletter_id
  end
end
