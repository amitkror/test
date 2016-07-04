require 'test_helper'

class ReferralEmailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: referral_emails
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  recipient  :string(255)     not null
#  subject    :string(255)     not null
#  message    :text
#  cc_me      :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

