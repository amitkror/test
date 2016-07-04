class FolderRecommendation < ActiveRecord::Base
  belongs_to :folder
  attr_accessible :demographic, :description, :demographic, :folder_id

  DEMOGRAPHICS = [
  								'High School Student',
                  'GED Student',
                  'College Student',
                  'Parent/Guardian',
                  'Adviser - School',
                  'Adviser - Non-profit',
                  'Other',
	  							]

	validates_inclusion_of :demographic, :in => FolderRecommendation::DEMOGRAPHICS

  class << self

  	def recommendation_status status
	  	unless status.nil?
	  		find(:all, :include => :folder, :conditions => {:folders => {:is_featured => status}})
	  	else
	  		all
	  	end
	  end

  end

end

# == Schema Information
#
# Table name: folder_recommendations
#
#  id          :integer         not null, primary key
#  folder_id   :integer
#  description :text
#  demographic :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

