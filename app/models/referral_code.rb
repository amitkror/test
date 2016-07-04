class ReferralCode < ActiveRecord::Base
  attr_accessible :code, :contest_id, :user_id

  validates :code, presence: true, uniqueness: true
  validates :contest_id, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :contest
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

