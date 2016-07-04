class RemovePagesFromNav < ActiveRecord::Migration
  def up
  	p = Page.where(:permalink => 'about').first
  	p.in_sub_nav = false
  	p.save

  	h = Page.where(:permalink => 'help').first
  	h.in_sub_nav = false
  	h.save

  end

  def down
  	p = Page.where(:permalink => 'about').first
  	p.in_sub_nav = true
  	p.save

  	h = Page.where(:permalink => 'help').first
  	h.in_sub_nav = true
  	h.save
  end
end
