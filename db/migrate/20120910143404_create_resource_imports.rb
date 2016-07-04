class CreateResourceImports < ActiveRecord::Migration
  def change
    create_table :resource_imports do |t|
      t.string :attachment_uid
      t.string :attachment_name

      t.timestamps
    end
  end
end
