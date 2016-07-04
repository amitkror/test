# == Schema Information
#
# Table name: forum_audiences
#
#  id          :integer         not null, primary key
#  forum_id    :integer         not null
#  audience_id :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class ForumAudience < ActiveRecord::Base
  # attr_accessible :title, :body
   # attr_accessible :title, :body
  belongs_to :forum
  belongs_to :audience
end
