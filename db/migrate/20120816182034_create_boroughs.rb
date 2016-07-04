class CreateBoroughs < ActiveRecord::Migration
  def change
    create_table :boroughs do |t|
      t.string :name, null: false
      t.integer :order, default: 0

      t.timestamps
    end
  end
end
