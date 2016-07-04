# == Schema Information
#
# Table name: page_resources
#
#  id          :integer         not null, primary key
#  page_id     :integer
#  resource_id :integer
#  order       :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class PageResource < ActiveRecord::Base

  belongs_to :page
  belongs_to :resource

  attr_accessible :order, :resource_id

  class << self
    def ordered
      order("page_resources.order")
    end
  end
end
