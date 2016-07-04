# == Schema Information
#
# Table name: page_faqs
#
#  id         :integer         not null, primary key
#  page_id    :integer
#  faq_id     :integer
#  order      :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class PageFaq < ActiveRecord::Base

  belongs_to :page
  belongs_to :faq, counter_cache: true

  attr_accessible :faq_id, :order

  class << self
    def ordered
      order("page_faqs.order")
    end
  end
end
