# == Schema Information
#
# Table name: event_boroughs
#
#  id         :integer         not null, primary key
#  event_id   :integer
#  borough_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class EventBorough < ActiveRecord::Base
  belongs_to :event
  belongs_to :borough
  # attr_accessible :title, :body
end
