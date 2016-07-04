require 'test_helper'

class ContestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: contests
#
#  id                  :integer         not null, primary key
#  name                :string(255)     not null
#  start_date          :date            not null
#  end_date            :date            not null
#  body                :text            not null
#  is_active           :boolean
#  email_trigger_count :integer         not null
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  sub_text            :text
#  bullet_1            :string(255)     default("Generate your code to begin!")
#  bullet_2            :string(255)     default("Share your link!")
#  bullet_3            :string(255)     default("Watch your referrals.")
#  generate_text       :string(255)     default("Generate your code to begin!")
#

