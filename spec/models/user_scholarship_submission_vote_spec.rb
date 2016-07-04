# == Schema Information
#
# Table name: user_scholarship_submission_votes
#
#  id                     :integer         not null, primary key
#  user_id                :integer
#  scholarship_submission :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

require 'spec_helper'

describe UserScholarshipSubmissionVote do
  pending "add some examples to (or delete) #{__FILE__}"
end
