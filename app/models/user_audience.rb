# == Schema Information
#
# Table name: user_audiences
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  audience_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  user_text   :text
#

class UserAudience < ActiveRecord::Base
  belongs_to :user
  belongs_to :audience

  attr_accessible :audience, :audience_id, :user_text, :_keep

  delegate :name, to: :audience, prefix: true
  delegate :display_user_text, :placeholder_text, :newsletter_id, to: :audience

  attr_accessor :_keep
end
