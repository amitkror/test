# == Schema Information
#
# Table name: system_avatars
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  image_uid  :string(255)     not null
#  image_name :string(255)     not null
#  order      :integer         default(0)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class SystemAvatar < ActiveRecord::Base

  image_accessor :image

  attr_accessible :image, :name, :order, :retained_image, :remove_image, :image_url

  validates :image, :name, presence: true
  validates_size_of :image, maximum: 1.megabytes,
    message: " is too large. Please, no larger than 1MB"

  class << self
    def ordered
      order("system_avatars.order")
    end

    def super_skinny
      select(["id", "name", "order"]
          .collect {|s| "system_avatars.#{s}"}.join(","))
    end

  end
end
