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

class PromoConnection < ActiveRecord::Base

  belongs_to :promo_instance

  attr_accessible :order, :promo_instance_id, :promoable_id, :promoable_type

  class << self
    def ordered
      order("promo_connections.order")
    end

    def rando
      order("rand()").limit(4)
    end

    def skinny
      select("promo_instance_id, promo_connections.order")
    end
  end
end
