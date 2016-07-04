# == Schema Information
#
# Table name: promo_instances
#
#  id             :integer         not null, primary key
#  is_locked      :boolean         default(FALSE)
#  title          :string(255)     not null
#  link           :string(255)     default("")
#  copy           :text            default("")
#  publish_date   :datetime
#  unpublish_date :datetime
#  promo_id       :integer
#  page_id        :integer
#  image_uid      :string(255)
#  image_name     :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  misc_text      :string(255)
#  color          :string(255)     default("")
#  rollover_uid   :string(255)
#  rollover_name  :string(255)
#

require 'spec_helper'

describe PromoInstance do
  pending "add some examples to (or delete) #{__FILE__}"
end
