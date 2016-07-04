module PromosHelper

  def promo_image_tag(instance, size)
    thumb = instance.image.thumb(size)
    opts = {}
    if instance.rollover_uid?
      opts = {
        data: {
          rollover: instance.rollover.thumb(size).url,
        },
        class: 'with-rollover',
      }
    end
    image_tag(thumb.url, opts.merge(alt: instance.title))
  end

  def get_promo_control(promo_connection)
    promo_connection.promo_instance.promo.control
  end

  def promo_image(instance, size='240x1000', skip_link=false)
    return "" if instance.image_uid.blank?
    link_to_unless skip_link, promo_image_tag(instance, size), promo_url(instance), title: instance.title
  end

  def promo_image_text(instance, size='240x1000')
    img = promo_image_tag(instance, size)
    text = "#{img} #{instance.title} #{instance.copy}"
    link_to text.html_safe, promo_url(instance), title: instance.title
  end

  def promo_url(instance)
    url = "#"
    url = instance.link unless instance.link.blank?
    url = instance.page.absolute_url unless instance.page.nil?
    url
  end
end
