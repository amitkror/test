require 'test_helper'

class GuestQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: guest_questions
#
#  id                      :integer         not null, primary key
#  guest_user_id           :integer         not null
#  adviser_id              :integer
#  topic_id                :integer
#  subject                 :string(255)
#  question                :text
#  answered                :boolean         default(FALSE)
#  accepts_tos             :boolean         default(TRUE)
#  new_comment_for_user    :boolean         default(FALSE)
#  new_for_adviser         :boolean         default(FALSE)
#  new_comment_for_adviser :boolean         default(FALSE)
#  last_commented_at       :datetime
#  last_commenter_id       :integer
#  comments_count          :integer         default(0)
#  created_at              :datetime        not null
#  updated_at              :datetime        not null
#

