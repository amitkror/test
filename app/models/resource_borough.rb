# == Schema Information
#
# Table name: resource_boroughs
#
#  id          :integer         not null, primary key
#  resource_id :integer
#  borough_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class ResourceBorough < ActiveRecord::Base
  belongs_to :resource
  belongs_to :borough
  # attr_accessible :title, :body
end
