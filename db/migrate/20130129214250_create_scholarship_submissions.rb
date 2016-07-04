class CreateScholarshipSubmissions < ActiveRecord::Migration
  def change
    create_table :scholarship_submissions do |t|
      t.string :first_name, default: "", null: false
      t.string :last_name, default: "", null: false
      t.string :high_school, default: "", null: false
      t.string :year_in_school, default: "", null: false
      t.string :email, default: "", null: false
      t.string :phone, default: "", null: false
      t.string :state, default: "", null: false
      t.string :birth_month, default: "", null: false
      t.string :birth_year, default: "", null: false
      t.boolean :not_currently_enrolled
      t.boolean :of_age_or_consent
      t.string :document_uid, null: false
      t.string :document_name, null: false
      t.string :video_url, default: "", null: false
      t.text :description
      t.boolean :agree_to_terms
      t.references :scholarship, null: false

      t.timestamps
    end
    add_index :scholarship_submissions, :scholarship_id
  end
end
