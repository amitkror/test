module Admissions::GalleriesHelper

  def slide_data(gallery)
    data = gallery.assets.map{ |asset| {
      id: asset.id,
      file: asset.attachment.thumb('500x34').url,
      url: edit_admin_asset_path(asset),
    }}
    return  data.to_json
  end
end
