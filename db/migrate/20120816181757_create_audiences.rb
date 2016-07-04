class CreateAudiences < ActiveRecord::Migration
  def change
    create_table :audiences do |t|
      t.string :name, null: false
      t.string :name_plural
      t.integer :order, default: 0
      t.boolean :show_in_filters, default: true
      t.boolean :show_in_settings, default: true

      t.timestamps
    end
  end
end
