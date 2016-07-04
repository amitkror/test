class CreateSystemAvatars < ActiveRecord::Migration
  def change
    create_table :system_avatars do |t|
      t.string :name, null: false
      t.string :image_uid, null: false
      t.string :image_name, null: false
      t.integer :order, default: 0

      t.timestamps
    end
  end
end
