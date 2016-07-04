module Admissions::PagesHelper

  def page_tree(page)
    kids = page.children.super_skinny
    return "" if kids.empty?
    r = ""
    kids.super_skinny.ordered.each do |p|
      r += render(partial: "list_item", locals: { page: p })
    end
    "<ul>#{r}</ul>".html_safe unless r.blank?
  end
end
