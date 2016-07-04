class CreateUserAudiences < ActiveRecord::Migration
  def change
    create_table :user_audiences do |t|
      t.references :user
      t.references :audience

      t.timestamps
    end
    add_index :user_audiences, :user_id
    add_index :user_audiences, :audience_id
  end
end
