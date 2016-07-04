class AddImageToCampaignPpc < ActiveRecord::Migration
  def change
    add_column :campaign_ppcs, :image_name, :string
    add_column :campaign_ppcs, :image_uid, :string
  end
end
