# == Schema Information
#
# Table name: resource_languages
#
#  id          :integer         not null, primary key
#  resource_id :integer         not null
#  language_id :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class ResourceLanguage < ActiveRecord::Base
  belongs_to :resource
  belongs_to :language
  # attr_accessible :title, :body
end
