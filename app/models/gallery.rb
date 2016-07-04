# == Schema Information
#
# Table name: galleries
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Gallery < ActiveRecord::Base

  has_many :gallery_assets
  has_many :assets, order: "gallery_assets.order", through: :gallery_assets

  attr_accessible :title, :asset_tokens

  attr_reader :asset_tokens

  validates :title, presence: true

  def asset_tokens=(ids)
    self.asset_ids = ids.split(",")
  end

  def thumb
    return "" unless self.gallery_assets.any?
    self.assets.first
  end

  def update_asset_order(ids)
    # logger.info "ids: #{ids}"
    ids = ids.split(",")
    self.gallery_assets.each do |ga|
      ga.order = ids.index(ga.asset_id.to_s)
      ga.save
      # logger.info "#{ga.id} #{ga.asset_id} #{ga.order}"
    end
  end

  class << self
    def ordered
      order("galleries.title")
    end

    def recent
      order("galleries.updated_at").reverse_order
    end
  end
end
