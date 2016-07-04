class CreateConditionsOfUses < ActiveRecord::Migration
  def change
    create_table :conditions_of_uses do |t|
      t.string :title, null: false
      t.text :copy, null: false

      t.timestamps
    end
  end
end
