class CreateQuickLinks < ActiveRecord::Migration
  def change
    create_table :quick_links do |t|
      t.string :text
      t.string :destination
      t.integer :order

      t.references :site_setting

      t.timestamps
    end
  end
end
