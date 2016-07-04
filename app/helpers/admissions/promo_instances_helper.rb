module Admissions::PromoInstancesHelper

  def promo_instance_thumb(promo_instance, size='100x75')
    return "" if promo_instance.image_uid.blank?
    image_tag promo_instance.image.thumb(size).url
  end

  def promo_instance_rollover_thumb(promo_instance, size='100x75')
    return "" if promo_instance.rollover_uid.blank?
    image_tag promo_instance.rollover.thumb(size).url
  end

end
