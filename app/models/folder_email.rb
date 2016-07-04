# == Schema Information
#
# Table name: folder_emails
#
#  id         :integer         not null, primary key
#  folder_id  :integer         not null
#  user_id    :integer         not null
#  recipient  :string(255)     not null
#  subject    :string(255)     not null
#  message    :text
#  cc_me      :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class FolderEmail < ActiveRecord::Base

  DEFAULT_SUBJECT = " has sent you college resources from NYC College Line"

  belongs_to :folder
  belongs_to :user

  attr_accessor :over
  attr_accessible :cc_me, :over, :message, :recipient, :subject

  delegate :email, :username, to: :user, prefix: true

  validates :user, :folder, :subject, :recipient, presence: true

  def over
    @over || false
  end

end
