class FaqsController < ApplicationController

  def index
    @page = Page.find_by_absolute_url!('/faq')
    @str = 'xx'
    @non_faq = []
    @cookies_arry = []
    
    if current_user.present?
      @audience_ids = current_user.audiences.pluck(:id)
          
      if cookies[:signin_faq]  
        faq_id = cookies[:signin_faq].scan(/\d+/).first
 
        page_first = Faq.find(faq_id.to_i).pages.where(:in_main_nav => true).first
         
        cookies[:faq2] = '' if cookies[:faq2].nil? 
          #if !cookies[:faq2].include? "#{page_first.permalink}"        
        cookies[:faq2] = cookies[:faq2] + " " + "#{page_first.permalink}" unless page_first.nil?
        #end      
        @str = cookies[:faq2]
      
        @cookies_arry = cookies[:faq2].split.compact.reverse.uniq
      end  
    else
    
      if cookies[:faq]  
        faq_id = cookies[:faq].scan(/\d+/).first
        
          page_first = Faq.find(faq_id.to_i).pages.where(:in_main_nav => true).first
          
          cookies[:faq2] = '' if cookies[:faq2].nil? 
          #if !cookies[:faq2].include? "#{page_first.permalink}"        
          cookies[:faq2] = cookies[:faq2] + " " + "#{page_first.permalink}" unless page_first.nil?
          #end      
          @str = cookies[:faq2]
      
          @cookies_arry = cookies[:faq2].split.compact.reverse.uniq
      end        
    end
    
  end
end
