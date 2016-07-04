class CreateResourceSubjects < ActiveRecord::Migration
  def change
    create_table :resource_subjects do |t|
      t.references :resource
      t.references :subject

      t.timestamps
    end
    add_index :resource_subjects, :resource_id
    add_index :resource_subjects, :subject_id
  end
end
