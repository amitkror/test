# == Schema Information
#
# Table name: resource_phases
#
#  id          :integer         not null, primary key
#  resource_id :integer         not null
#  phase_id    :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class ResourcePhase < ActiveRecord::Base
  belongs_to :resource
  belongs_to :phase
  # attr_accessible :title, :body
end
