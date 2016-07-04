class Contest < ActiveRecord::Base
  attr_accessible :body, :end_date, :name, :start_date, :is_active, :email_trigger_count,
                  :sub_text, :bullet_1, :bullet_2, :bullet_3, :generate_text

  validates :name, :body, :start_date, :end_date, :email_trigger_count, presence: true

  has_many :referral_codes
  has_many :referrers, through: :referral_codes, source: :user
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

