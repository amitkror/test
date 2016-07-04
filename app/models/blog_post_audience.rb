# == Schema Information
#
# Table name: blog_post_audiences
#
#  id           :integer         not null, primary key
#  blog_post_id :integer         not null
#  audience_id  :integer         not null
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class BlogPostAudience < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :blog_post
  belongs_to :audience
end
