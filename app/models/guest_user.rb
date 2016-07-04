class GuestUser < ActiveRecord::Base
  attr_accessible :email, :zipcode
  before_create :make_secret_code
  validates :email, :zipcode, presence: true

  has_many :guest_questions, dependent: :destroy
  has_many :comments, dependent: :destroy

  def username
    email
  end

  def user_email
    email
  end

  def make_secret_code
    self.secret_code = SecureRandom.hex
  end
end

# == Schema Information
#
# Table name: guest_users
#
#  id          :integer         not null, primary key
#  email       :string(255)     not null
#  zipcode     :string(255)
#  secret_code :string(255)     not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

