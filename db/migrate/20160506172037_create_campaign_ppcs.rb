class CreateCampaignPpcs < ActiveRecord::Migration
  def change
    create_table :campaign_ppcs do |t|
      t.string :title
      t.text :body
      t.string :permalink

      t.timestamps
    end
    add_index :campaign_ppcs, :permalink, unique: true
  end
end
