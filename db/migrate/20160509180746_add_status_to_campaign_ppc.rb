class AddStatusToCampaignPpc < ActiveRecord::Migration
  def change
  	add_column :campaign_ppcs, :status_id, :integer
  end
end
