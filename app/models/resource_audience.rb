# == Schema Information
#
# Table name: resource_audiences
#
#  id          :integer         not null, primary key
#  resource_id :integer         not null
#  audience_id :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class ResourceAudience < ActiveRecord::Base
  belongs_to :resource
  belongs_to :audience
  # attr_accessible :title, :body
end
