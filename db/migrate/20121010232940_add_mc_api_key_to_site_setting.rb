class AddMcApiKeyToSiteSetting < ActiveRecord::Migration
  def change
    add_column :site_settings, :mc_api_key, :string
  end
end
