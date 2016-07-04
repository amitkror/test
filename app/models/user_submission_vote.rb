# == Schema Information
#
# Table name: user_submission_votes
#
#  id                        :integer         not null, primary key
#  user_id                   :integer
#  scholarship_submission_id :integer
#  created_at                :datetime        not null
#  updated_at                :datetime        not null
#

class UserSubmissionVote < ActiveRecord::Base
  # Relations
  belongs_to :scholarship_submission, counter_cache: true
  belongs_to :user

  # Attribute availability
  attr_accessible :scholarship_submission, :user

  class << self

    def already_voted?(user_id, submission_id)
      UserSubmissionVote.where(
        user_id: user_id,
        scholarship_submission_id: submission_id
      ).exists?
    end

    def find_by_user_and_submission(user_id, submission_id)
      UserSubmissionVote.where(
        user_id: user_id,
        scholarship_submission_id: submission_id
      ).first
    end

  end

end
