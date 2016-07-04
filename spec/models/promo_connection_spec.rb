# == Schema Information
#
# Table name: promo_connections
#
#  id                :integer         not null, primary key
#  order             :integer         default(0)
#  promo_instance_id :integer
#  promoable_id      :integer
#  promoable_type    :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

require 'spec_helper'

describe PromoConnection do
  pending "add some examples to (or delete) #{__FILE__}"
end
