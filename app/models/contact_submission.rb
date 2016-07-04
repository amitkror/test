# == Schema Information
#
# Table name: contact_submissions
#
#  id         :integer         not null, primary key
#  title      :string(255)     not null
#  name       :string(255)     not null
#  email      :string(255)     not null
#  message    :text            not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class ContactSubmission < ActiveRecord::Base

  attr_accessible :email, :message, :name, :title

  validates :email, :message, :name, :title, presence: true
  validates :email, :name, :title, length: { maximum: 255 }

  class << self
    def ordered
      order("created_at DESC")
    end
  end

end
