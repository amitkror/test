# == Schema Information
#
# Table name: resource_supports
#
#  id          :integer         not null, primary key
#  resource_id :integer
#  support_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class ResourceSupport < ActiveRecord::Base
  belongs_to :resource
  belongs_to :support
  # attr_accessible :title, :body
end
