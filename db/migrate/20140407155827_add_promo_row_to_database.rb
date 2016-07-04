class AddPromoRowToDatabase < ActiveRecord::Migration
  def self.up
  	@promo = Promo.new(:is_locked => false, :is_image => false, :title => 'Featured Public Folders', :control => 'featured_public_folders')
  	@promo.save
  end

  def self.down
  	Promo.delete_all :control => 'featured_public_folders'
  end

end
