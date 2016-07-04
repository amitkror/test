class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.boolean :is_locked, default: true
      t.boolean :is_image, default: false
      t.string :title, null: false
      t.string :control, null: false

      t.timestamps
    end
  end
end
