require 'test_helper'

class ReferralTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: referrals
#
#  id          :integer         not null, primary key
#  referrer_id :integer         not null
#  referred_id :integer         not null
#  contest_id  :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

