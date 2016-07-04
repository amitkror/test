# == Schema Information
#
# Table name: resource_subway_lines
#
#  id             :integer         not null, primary key
#  resource_id    :integer         not null
#  subway_line_id :integer         not null
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

class ResourceSubwayLine < ActiveRecord::Base
  belongs_to :resource
  belongs_to :subway_line
  # attr_accessible :title, :body
end
