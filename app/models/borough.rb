# == Schema Information
#
# Table name: boroughs
#
#  id               :integer         not null, primary key
#  name             :string(255)     not null
#  order            :integer         default(0)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  show_in_filters  :boolean         default(TRUE)
#  show_in_settings :boolean         default(TRUE)
#

class Borough < ActiveRecord::Base

  has_many :users

  attr_accessible :name, :order

  validates :name, presence: true

  class << self
    def ordered
      order("boroughs.order")
    end

    def filters
      select("id, name")
        .where(show_in_filters: true)
        .ordered
    end

    def settings
      select("id, name")
        .where(show_in_settings: true)
        .ordered
    end
  end
end
