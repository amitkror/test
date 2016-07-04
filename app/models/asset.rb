# == Schema Information
#
# Table name: assets
#
#  id              :integer         not null, primary key
#  title           :string(255)     default("")
#  alt             :string(255)     default("")
#  page_id         :integer
#  link            :string(255)
#  attachment_uid  :string(255)     not null
#  attachment_name :string(255)     not null
#  is_image        :boolean         default(FALSE)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class Asset < ActiveRecord::Base

  image_accessor :attachment

  belongs_to :page
  has_many :resource_asset

  attr_accessible :alt, :attachment, :link, :order, :page_id,
                  :retained_attachment, :title, :attachment_url
  attr_accessor :order

  validates :attachment_name, presence: true
  validates :title, presence: true

  validates_size_of :attachment, maximum: 10.megabytes,
    message: " is too large. Please, no larger than 10MB"

  after_commit :set_is_image
  before_validation :set_title

  private
    def set_title

      puts '*&#)$%)*&#^$@)*$^@$%^_#$%^_#@&$^)@#*&$^@)#*&$^'
      puts self.inspect

      self.title = self.attachment_name.gsub('.' + self.attachment.ext, '') \
          if self.title.blank?
    end

    def set_is_image
      self.is_image = (self.attachment.image? && self.attachment.ext != "pdf") \
          unless self.attachment_uid.blank?
      self.save if self.is_image_changed?
      true
    end

  class << self

    def images
      where(is_image: true)
    end

    def recent
      order("assets.updated_at").reverse_order
    end

    def super_skinny
      select(["id", "title", "attachment_name", "attachment_uid", "updated_at"]\
          .collect {|s| "assets.#{s}"}.join(","))
    end
  end
end
