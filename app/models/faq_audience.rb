# == Schema Information
#
# Table name: faq_audiences
#
#  id          :integer         not null, primary key
#  faq_id      :integer         not null
#  audience_id :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class FaqAudience < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :faq
  belongs_to :audience
end
