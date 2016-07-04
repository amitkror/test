# == Schema Information
#
# Table name: gallery_assets
#
#  id         :integer         not null, primary key
#  gallery_id :integer         not null
#  asset_id   :integer         not null
#  order      :integer         default(0)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class GalleryAsset < ActiveRecord::Base

  belongs_to :gallery
  belongs_to :asset

  attr_accessible :asset_id, :order, :gallery_id

  validates :asset, :gallery, presence: true
end
