# == Schema Information
#
# Table name: event_subway_lines
#
#  id             :integer         not null, primary key
#  event_id       :integer
#  subway_line_id :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

class EventSubwayLine < ActiveRecord::Base
  belongs_to :event
  belongs_to :subway_line
  # attr_accessible :title, :body
end
