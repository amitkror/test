class CreateResourceLanguages < ActiveRecord::Migration
  def change
    create_table :resource_languages do |t|
      t.references :resource, null: false
      t.references :language, null: false

      t.timestamps
    end
    add_index :resource_languages, :resource_id
    add_index :resource_languages, :language_id
  end
end
