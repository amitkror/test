class PublicFolderConnection < ActiveRecord::Base
  belongs_to :folder
  attr_accessible :order, :folder_id

  belongs_to :site_setting

  validates_presence_of :folder_id
  
end

# == Schema Information
#
# Table name: public_folder_connections
#
#  id              :integer         not null, primary key
#  folder_id       :integer
#  site_setting_id :integer
#  order           :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

