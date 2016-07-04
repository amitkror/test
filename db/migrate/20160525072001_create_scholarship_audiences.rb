class CreateScholarshipAudiences < ActiveRecord::Migration
  def change
    create_table :scholarship_audiences do |t|

      t.references :scholarship, null: false
      t.references :audience, null: false

      t.timestamps
    end
    add_index :scholarship_audiences, :scholarship_id
    add_index :scholarship_audiences, :audience_id
  end
end
