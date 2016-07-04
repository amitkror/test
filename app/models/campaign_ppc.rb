# == Schema Information
#
# Table name: campaign_ppcs
#
#  id                       :integer         not null, primary key
#  title                    :string(255)
#  body                     :string(255)
#  permalink                :string(255)
#  created_at               :datetime        not null
#  updated_at               :datetime        not null
#  status_id                :integer
#  image_name               :string(255)
#  image_uid                :string(255)
#  meta_description         :string(255)
#  meta_title               :string(255)
#  meta_keywords            :string(255)
#  advertisement_image_link :string(255)
#  contact_form_email       :string(255)
#

class CampaignPpc < AbstractPermalink
 
  image_accessor :image
  attr_accessible :body, :permalink, :title, :status_id, :image_url,
    :image, :meta_description, :meta_title, :meta_keywords,
    :advertisement_image_link, :contact_form_email
 
  validates_presence_of :title
  validates_uniqueness_of :permalink
  
end
