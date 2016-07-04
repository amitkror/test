# == Schema Information
#
# Table name: phases
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  order      :integer         default(0)
#  teaser     :text            default("")
#  page_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Phase < ActiveRecord::Base

  belongs_to :page

  attr_accessible :name, :order, :page_id, :teaser

  delegate :absolute_url, to: :page, prefix: true, allow_nil: true

  validates :name, :teaser, presence: true

  class << self
    def ordered
      order("phases.order")
    end
  end
end
