module SearchHelper

  def tab_nav(tab_path, current_type)
    path = request.fullpath.split('?')[0] + "?" + tab_path
    cls = current_type.blank? ? ' class="on"' : ''
    nav = "<li><a href=\"#{path}\"#{cls}>All<br/>Resources</a></li>"
    nav = nav + tab_item(current_type, path, 1, "program")
    nav = nav + tab_item(current_type, path, 2, "website")
    nav = nav + tab_item(current_type, path, 3, "video")
    nav = nav + tab_item(current_type, path, 4, "tutorial")
    nav = nav + tab_item(current_type, path, 5, "document")   
    return nav.html_safe
  end

  def tab_item(current_type, path, tab_type, tab_name)
    on = current_type == tab_type
    path = path + (on ? "" : "&amp;type=#{tab_type}")
    cls = current_type == tab_type ? ' class="on"' : ''
    "<li><a href=\"#{path}\"#{cls} data-type=\"#{tab_type}\"><i class=\"ico ico-#{tab_name}\"></i>#{tab_name.capitalize}s</a></li>"
  end

  def record_title(record)
    if record.class.to_s == 'BlogPost'
      return record.title.html_safe  
    elsif record.class.to_s == 'Event'
      return record.name.html_safe
    elsif record.class.to_s == 'Faq'
      return record.question.html_safe
    elsif record.class.to_s == 'ForumThread'
      return record.name.html_safe
    elsif record.class.to_s == 'Scholarship'
      return record.name.html_safe
    elsif record.class.to_s == 'Resource'
      return record.name.html_safe  
    end
  end

  def record_body(record)
    if record.class.to_s == 'BlogPost'      
      return truncate(strip_tags(record.body), :length => 400).html_safe      
    elsif record.class.to_s == 'Event'
      return truncate(strip_tags(record.body), :length => 400).html_safe
    elsif record.class.to_s == 'Faq'
      return truncate(strip_tags(record.answer), :length => 400).html_safe
    elsif record.class.to_s == 'ForumThread'      
      return truncate(strip_tags(record.message), :length => 400).html_safe
    elsif record.class.to_s == 'Scholarship'
      return truncate(strip_tags(record.copy), :length => 400).html_safe
    elsif record.class.to_s == 'Resource'
      return truncate(strip_tags(record.body), :length => 400).html_safe 
    end
  end

  def record_link(record)
    if record.class.to_s == 'BlogPost'      
      return "/blog/#{record.permalink}"
    elsif record.class.to_s == 'Event'
      return "/events/#{record.permalink}"
    elsif record.class.to_s == 'Faq'      
      return "/faq#?faq=faq-#{record.id}"      
    elsif record.class.to_s == 'ForumThread'
      type = Forum.find(record.forum_id).permalink      
      return "/forums/#{type}/threads/#{record.permalink}"      
    elsif record.class.to_s == 'Scholarship'
      return "/scholarships/#{record.permalink}"
    elsif record.class.to_s == 'Resource'
      return "/resources/#{record.permalink}"  
    end
  end

end
