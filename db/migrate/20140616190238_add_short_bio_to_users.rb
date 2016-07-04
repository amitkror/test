class AddShortBioToUsers < ActiveRecord::Migration
  def up
  	change_table :users do |t|
      t.column :bio, :text
    end
  end
  def down
  	change_table :users do |t|
      t.remove :bio
    end
  end
end
