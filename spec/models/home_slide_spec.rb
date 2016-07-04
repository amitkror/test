# == Schema Information
#
# Table name: home_slides
#
#  id              :integer         not null, primary key
#  image_uid       :string(255)
#  image_name      :string(255)
#  order           :integer
#  url             :string(255)
#  page_id         :integer
#  site_setting_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

require 'spec_helper'

describe HomeSlide do
  pending "add some examples to (or delete) #{__FILE__}"
end
