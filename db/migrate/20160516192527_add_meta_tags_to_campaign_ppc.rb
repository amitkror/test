class AddMetaTagsToCampaignPpc < ActiveRecord::Migration
  def change
  	add_column :campaign_ppcs, :meta_description, :string
  	add_column :campaign_ppcs, :meta_title, :string
  	add_column :campaign_ppcs, :meta_keywords, :string
  	add_column :campaign_ppcs, :advertisement_image_link, :string
  	add_column :campaign_ppcs, :contact_form_email, :string
  end
end
