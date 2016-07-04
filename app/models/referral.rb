class Referral < ActiveRecord::Base
  attr_accessible :referred_id, :referrer_id, :contest_id

  belongs_to :referrer, class_name: "User", foreign_key: "referrer_id"
  belongs_to :referred, class_name: "User", foreign_key: "referred_id"

  belongs_to :contest
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

