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

require 'spec_helper'

describe GalleryAsset do
  pending "add some examples to (or delete) #{__FILE__}"
end
