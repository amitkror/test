# == Schema Information
#
# Table name: event_audiences
#
#  id          :integer         not null, primary key
#  event_id    :integer         not null
#  audience_id :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class EventAudience < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :event
  belongs_to :audience
end
