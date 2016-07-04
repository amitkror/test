# == Schema Information
#
# Table name: site_settings
#
#  id         :integer         not null, primary key
#  mc_api_key :string(255)
#

class SiteSetting < ActiveRecord::Base

  has_many :home_slides, dependent: :destroy, order: "home_slides.order"
  has_many :promo_connections, as: :promoable, order: "promo_connections.order"

	has_many :public_folder_connections, order: "public_folder_connections.order"  

  has_many :quick_links, order: "quick_links.order"  

  attr_accessible :home_slides_attributes, :image, :mc_api_key,
                  :promo_connections_attributes, :public_folder_connections_attributes, :quick_links_attributes

  accepts_nested_attributes_for :home_slides, allow_destroy: true
  accepts_nested_attributes_for :promo_connections, allow_destroy: true

  accepts_nested_attributes_for :public_folder_connections, allow_destroy: true

  accepts_nested_attributes_for :quick_links, allow_destroy: true

  def promos
    self.promo_connections.ordered
  end

end
