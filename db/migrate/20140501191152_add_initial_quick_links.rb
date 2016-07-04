class AddInitialQuickLinks < ActiveRecord::Migration
  def up
  	QuickLink.new(:text => 'Getting into college', :destination => '/apply', :order => 0, :site_setting_id => 1).save
  	QuickLink.new(:text => 'Paying for College', :destination => '/pay-for-college', :order => 1, :site_setting_id => 1).save
  	QuickLink.new(:text => 'Staying in college', :destination => '/succeed-in-college', :order => 2, :site_setting_id => 1).save
  end

  def down
  end
end
