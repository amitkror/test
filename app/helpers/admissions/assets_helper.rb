module Admissions::AssetsHelper

  def asset_icon(asset)
    image_tag ext_icon(asset.attachment.ext.downcase)
  end

  def ext_icon(ext)
    dir = '/assets/admin/icons/file_extension_'
    case ext
      when 'doc', 'docx'
        dir += 'doc.png'
      when 'eps'
        dir += 'eps.png'
      when 'pdf'
        dir += 'pdf.png'
      when 'psd'
        dir += 'psd.png'
      when 'rtf'
        dir += 'rtf.png'
      when 'ttf'
        dir += 'ttf.png'
      when 'txt'
        dir += 'txt.png'
      when 'xls', 'xlxs'
        dir += 'xls.png'
      when 'zip'
        dir += 'zip.png'
      else
        dir += 'default.png'
    end
    dir
  end

  def asset_thumb(asset, size='100x75', full_path=false)

    return "" if asset.blank?

    return asset_icon(asset) unless asset.is_image

    if asset.attachment_uid
      image = asset.attachment
    else
      image = Dragonfly[:images].fetch_file(File.join(Rails.root,
        'app', 'assets', 'images', 'missing.png'))
    end

    if full_path
      image_tag root_url[0..-2] + image.thumb(size).url
    else
      image_tag image.thumb(size).url
    end
  end

  def admin_thumb(image, size='100x75', url='')

    return "" if image.blank?

    img = image_tag image.thumb(size).url
    url = url.blank? ? image.url : url
    "<a href=\"#{url}\" target=\"_blank\">#{img}</a>".html_safe

  end

  def admin_file_thumb(file)

    return "" if file.blank?

    img = image_tag ext_icon(file.ext.downcase)
    "<a href=\"#{file.url}\" target=\"_blank\">#{img}</a>".html_safe
  end
end
