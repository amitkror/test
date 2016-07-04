class CreateUserScholarshipSubmissionVotes < ActiveRecord::Migration
  def change
    create_table :user_submission_votes do |t|
      t.references :user
      t.references :scholarship_submission

      t.timestamps
    end
    add_index :user_submission_votes, :user_id
    add_index :user_submission_votes, :scholarship_submission_id
  end
end
