class CreateGlossaryTerms < ActiveRecord::Migration
  def change
    create_table :glossary_terms do |t|
      t.string :name, null: false
      t.string :url
      t.text :definition, null: false

      t.timestamps
    end
  end
end
