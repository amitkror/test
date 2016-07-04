# == Schema Information
#
# Table name: page_assets
#
#  id         :integer         not null, primary key
#  page_id    :integer
#  asset_id   :integer
#  order      :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class PageAsset < ActiveRecord::Base

  belongs_to :page
  belongs_to :asset

  attr_accessible :order

  class << self
    def ordered
      order("page_assets.order")
    end
  end
end
