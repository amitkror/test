class AddVotingStartDateToScholarships < ActiveRecord::Migration
  def change
    add_column :scholarships, :voting_start_date, :datetime
    add_column :scholarships, :voting_end_date, :datetime
    add_column :scholarships, :voting_title, :string, default: "Vote for the winner"
    add_column :scholarships, :voting_copy, :text

    add_column :scholarship_submissions, :video_embed, :text
    add_column :scholarship_submissions, :thumbnail_uid, :string
    add_column :scholarship_submissions, :thumbnail_name, :string
    add_column :scholarship_submissions, :selected_entry, :boolean, default: false
    add_column :scholarship_submissions, :user_submission_votes_count, :integer, default: 0

    add_column :scholarship_submissions, :school_type_id, :integer, default: 0
    add_column :scholarship_submissions, :title, :string
    add_column :scholarship_submissions, :order, :integer, default: 0
  end
end
