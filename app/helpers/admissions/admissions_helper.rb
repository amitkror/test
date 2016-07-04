module Admissions::AdmissionsHelper

  def administrator_greeting
    return "" unless user_signed_in?
    "#{["Howdy", "Hola", "Hey there", "Welcome", "Bonjour"].sample} #{current_user.full_name}!".html_safe
  end

  def admin_on_class(path)
    'on' if request.fullpath.starts_with? path
  end

  def has_audience?(obj, audience)
    return obj.audience_ids.include?(audience.id) if !obj.new_record?
    false
  end

  def has_borough?(obj, borough)
    return obj.borough_ids.include?(borough.id) if !obj.new_record?
    false
  end

  def has_language?(obj, language)
    return obj.language_ids.include?(language.id) if !obj.new_record?
    false
  end

  def has_newsletter?(obj, newsletter)
    return obj.newsletter_ids.include?(newsletter.id) if !obj.new_record?
    false
  end

  def has_phase?(obj, phase)
    return obj.phase_ids.include?(phase.id) if !obj.new_record?
    false
  end

  def has_subject?(obj, subject)
    return obj.subject_ids.include?(subject.id) if !obj.new_record?
    false
  end

  def has_subway_line?(obj, subway_line)
    return obj.subway_line_ids.include?(subway_line.id) if !obj.new_record?
    false
  end

  def has_support?(obj, support)
    return obj.support_ids.include?(support.id) if !obj.new_record?
    false
  end

  def make_readable(m)
    m.class.name.underscore.humanize.downcase
  end

  def sortable_header(order, text="", default=false)
    text = order.titleize if text.blank?
    dir = params[:dir] == "desc" ? "asc" : "desc"
    klass = (params[:order] == order || (params[:order].blank? && default)) ? "on" : ""
    args = params.merge({ order: order, dir: dir })
    args.delete(:controller)
    args.delete(:action)
    args.delete(:type)
    link_to(spaceless(text), "?" + args.to_query, class: "#{klass} #{dir}").html_safe
  end

  def per_page(n)
    ret = n > 10 ? " | " : ""
    ret += (link_to "#{n}", "?per_page=#{n}", class: (@per_page.to_s == n.to_s ? "on" : ""), title: n)
    ret.html_safe
  end
end
