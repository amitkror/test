# == Schema Information
#
# Table name: scholarship_audiences
#
#  id             :integer         not null, primary key
#  scholarship_id :integer         not null
#  audience_id    :integer         not null
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

class ScholarshipAudience < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :scholarship
  belongs_to :audience
end
