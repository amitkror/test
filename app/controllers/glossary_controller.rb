class GlossaryController < ApplicationController

  def index
    @page = Page.find_by_absolute_url!("/glossary",
      select: "id, title, meta_description, teaser, copy")
    @sorted_terms = sort_terms(GlossaryTerm.all.group_by { |g|
      g.name.upcase.first
    })
  end

  #convert a hash into an array sorted alphabetically by the key
  def sort_terms(hash)
    sorted = []
    hash.each do |key, value|
      sorted << [key.upcase, value]
    end
    sorted.sort{ |x,y| x[0] <=> y[0] }
  end
end
