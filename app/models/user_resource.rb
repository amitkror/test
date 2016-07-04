# == Schema Information
#
# Table name: user_resources
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  resource_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class UserResource < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource
  # attr_accessible :title, :body
end
