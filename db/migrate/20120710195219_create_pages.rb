class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :status_id, default: 1
      t.integer :page_type_id, default: 1
      t.integer :order, default: 0
      t.boolean :locked, default: false
      t.boolean :in_main_nav, default: false
      t.boolean :in_sub_nav, default: false
      t.string :title, null: false
      t.string :short_title, default: ''
      t.string :permalink, null: false
      t.string :absolute_url, null: false
      t.string :redirect, default: ''
      t.text :copy, default: ''
      t.text :meta_description, default: ''
      t.text :teaser, default: ''
      t.string :resources_title, default: 'Recommended Resources'
      t.string :resources_subtitle, default: ''
      # ancestry properties
      t.integer :ancestry_depth, default: 0
      t.string :ancestry
      t.references :gallery

      t.timestamps
    end
    add_index :pages, :absolute_url, unique: true
    add_index :pages, :permalink
    add_index :pages, :ancestry
    add_index :pages, :status_id
    add_index :pages, :gallery_id
  end
end
