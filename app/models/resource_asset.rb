# == Schema Information
#
# Table name: resource_assets
#
#  id          :integer         not null, primary key
#  resource_id :integer
#  asset_id    :integer
#  order       :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class ResourceAsset < ActiveRecord::Base

  belongs_to :resource
  belongs_to :asset

  attr_accessible :order

  class << self
    def ordered
      order("resource_assets.order")
    end
  end
end
