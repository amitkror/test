require 'test_helper'

class ReferralCodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: referral_codes
#
#  id         :integer         not null, primary key
#  contest_id :integer         not null
#  user_id    :integer         not null
#  code       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

