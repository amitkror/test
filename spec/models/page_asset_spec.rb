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

require 'spec_helper'

describe PageAsset do
  pending "add some examples to (or delete) #{__FILE__}"
end
