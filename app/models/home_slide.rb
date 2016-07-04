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

class HomeSlide < ActiveRecord::Base

  image_accessor :image

  belongs_to :page
  belongs_to :site_setting

  attr_accessible :image, :image, :order, :url, :image_url

  validates_size_of :image, maximum: 10.megabytes,
    message: " is too large. Please, no larger than 10MB"

  class << self
    def make_image_thumbnails
      HomeSlide.all.each do |slide|
        slide.update_attributes(image_url: slide.image.remote_url)
      end
    end
  end

end
