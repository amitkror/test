class AddFormatAndPromptToScholarships < ActiveRecord::Migration
  def up
    add_column :scholarships, :submission_format, :text, default: ""
    add_column :scholarships, :submission_prompt, :text, default: ""
    add_column :scholarships, :thank_you, :text, default: ""

    add_column :scholarship_submissions, :submission_format, :text, default: ""
    add_column :scholarship_submissions, :submission_prompt, :text, default: ""

    change_column :scholarship_submissions, :document_uid, :string, null: true
    change_column :scholarship_submissions, :document_name, :string, null: true
    change_column :scholarship_submissions, :video_url, :string, default: "", null: true
  end

  def down
    remove_column :scholarships, :submission_format
    remove_column :scholarships, :submission_prompt
    remove_column :scholarships, :thank_you

    remove_column :scholarship_submissions, :submission_format
    remove_column :scholarship_submissions, :submission_prompt

    change_column :scholarship_submissions, :document_uid, :string, null: false
    change_column :scholarship_submissions, :document_name, :string, null: false
    change_column :scholarship_submissions, :video_url, :string, default: "", null: false
  end
end
