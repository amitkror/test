class QuickLink < ActiveRecord::Base
  attr_accessible :destination, :text, :order, :site_setting_id

  validates_presence_of :destination, :text

  belongs_to :site_setting

end

# == Schema Information
#
# Table name: quick_links
#
#  id              :integer         not null, primary key
#  text            :string(255)
#  destination     :string(255)
#  order           :integer
#  site_setting_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

