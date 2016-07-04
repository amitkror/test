# == Schema Information
#
# Table name: promos
#
#  id         :integer         not null, primary key
#  is_locked  :boolean         default(TRUE)
#  is_image   :boolean         default(FALSE)
#  title      :string(255)     not null
#  control    :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Promo < ActiveRecord::Base

  attr_accessible :title, :is_locked, :is_image, :control

  # :is_locked => false, :is_image => false, :title => 'Login/Register CTA', :control => 'login_register_cta'

  validates :title, :control, presence: true

  class << self
    def unlocked
      where(is_locked: false)
    end
  end
end
