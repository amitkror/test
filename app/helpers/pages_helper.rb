module PagesHelper

  def copy(copy)
=begin
    gre = /<p>%%gallery-(\d)*%%<\/p?>|%%gallery-(\d)*%%/
    matches = copy.split(gre)
    matches.each do |m|
      id = m.to_i
      next if id == 0
      if Gallery.exists?(id)
        matches[matches.index(m)] = render partial: 'galleries/show',
            locals: {gallery: Gallery.find(id)}
      else
        matches[matches.index(m)] = ''
      end
    end
    copy = matches.join('') unless matches.nil?
=end
    copy.html_safe
  end

end