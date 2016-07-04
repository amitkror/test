class Tag < AbstractPermalink

	# has_many :tag_taggables
	has_and_belongs_to_many :blog_posts

  attr_accessible :permalink, :title

  class << self
  	def used
	  	# all
	  	select('DISTINCT tags.*').joins(:blog_posts).where('blog_posts.id IS NOT NULL')
	  end
	end
  
end

# == Schema Information
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  permalink  :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

