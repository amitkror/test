# == Schema Information
#
# Table name: audiences
#
#  id                :integer         not null, primary key
#  name              :string(255)     not null
#  name_plural       :string(255)
#  order             :integer         default(0)
#  show_in_filters   :boolean         default(TRUE)
#  show_in_settings  :boolean         default(TRUE)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  display_user_text :boolean         default(FALSE)
#  placeholder_text  :string(255)
#  newsletter_id     :integer
#

class Audience < ActiveRecord::Base

  attr_accessible :name, :name_plural, :order, :show_in_filters,
                  :show_in_settings, :display_user_text, :placeholder_text, :newsletter_id

  validates :name, presence: true

  belongs_to :newsletter

  class << self
    def ordered
      order("audiences.order")
    end

    def filters
      select("id, name_plural")
        .where(show_in_filters: true)
    end

    def settings
      select("id, name, display_user_text, placeholder_text, newsletter_id")
        .where(show_in_settings: true)
        .ordered
    end

  end
end
