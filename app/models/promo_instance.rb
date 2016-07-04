# == Schema Information
#
# Table name: promo_instances
#
#  id             :integer         not null, primary key
#  is_locked      :boolean         default(FALSE)
#  title          :string(255)     not null
#  link           :string(255)     default("")
#  copy           :text            default("")
#  publish_date   :datetime
#  unpublish_date :datetime
#  promo_id       :integer
#  page_id        :integer
#  image_uid      :string(255)
#  image_name     :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  misc_text      :string(255)
#  color          :string(255)     default("")
#  rollover_uid   :string(255)
#  rollover_name  :string(255)
#

class PromoInstance < ActiveRecord::Base

  COLORS = {
    'bright blue' => 'bright-blue',
    'green' => 'green',
    'light gray' => 'light-gray',
    'light blue' => 'light-blue',
    'dark blue' => 'dark-blue',
  }

  image_accessor :image
  image_accessor :rollover

  belongs_to :page
  belongs_to :promo
  has_many :promo_connections, dependent: :destroy

  attr_accessible :color, :copy, :image, :link, :misc_text, :page_id, :promo_id,
                  :publish_date, :retained_image, :title, :unpublish_date,
                  :rollover, :retained_rollover, :image_url, :rollover_url

  delegate :title, to: :promo, prefix: true

  validates :title, presence: true
  validates_size_of :image, maximum: 10.megabytes,
    message: " is too large. Please, no larger than 10MB"
  validates_size_of :rollover, maximum: 10.megabytes,
    message: " is too large. Please, no larger than 10MB"

  def url
    url = "#"
    url = self.link unless self.link.blank?
    url = self.page.absolute_url unless self.page.nil?
    url
  end

  class << self
    def ordered
      order(:title)
    end

    def unlocked
      where(is_locked: false)
    end
  end
end
