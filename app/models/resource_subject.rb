# == Schema Information
#
# Table name: resource_subjects
#
#  id          :integer         not null, primary key
#  resource_id :integer
#  subject_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class ResourceSubject < ActiveRecord::Base
  belongs_to :resource
  belongs_to :subject
  # attr_accessible :title, :body
end
