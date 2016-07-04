module ApplicationHelper
  # Meta tag helpers
  def default_title
    "NYC College Line"
  end

  def blog_post_title(blog_post)
    if blog_post.meta_title.present?
      return "#{blog_post.meta_title}"
    else
      return "#{blog_post.title}"
    end
  end

  def blog_post_description(blog_post)
    if blog_post.meta_description.present?
      return "#{blog_post.meta_description}"
    else
      return "#{blog_post.tagline}"
    end
  end

  def blog_post_keywords(blog_post)
    if blog_post.meta_description.present?
      return "#{blog_post.meta_keywords}"
    else
      return ""
    end
  end

  def campaign_ppc_title(campaign_ppc)
    if campaign_ppc.meta_title.present?
      return "#{campaign_ppc.meta_title}"
    else
      return "#{campaign_ppc.title}"
    end
  end

  def campaign_ppc_description(campaign_ppc)
    if campaign_ppc.meta_description.present?
      return "#{campaign_ppc.meta_description}"
    else
      return ""
    end
  end

  def campaign_ppc_keywords(campaign_ppc)
    if campaign_ppc.meta_description.present?
      return "#{campaign_ppc.meta_keywords}"
    else
      return ""
    end
  end

  def title(page_title)
    content_for(:title) { "#{page_title.to_s} :: #{default_title}" }
  end

  def meta_description(description)
    description = strip_tags(description).split[0...80].join(' ')
    content_for(:meta_description) { "#{description.to_s}" }
  end

  # Navigation helpers
  def on_class(path)
    'on' if request.fullpath.starts_with? path
  end

  def main_nav
    if Rails.env.development?
      return Page.active.ordered.super_skinny.where(in_main_nav: true)
    end
    Rails.cache.fetch("main_nav", expires_in: 15.minutes) do
      Page.active.ordered.super_skinny.where(in_main_nav: true)
    end
  end

  def child_nav(page)
    Rails.cache.fetch("child_nav_#{page.id}", expires_in: 15.minutes) do
      page.children.active.ordered.super_skinny
    end
  end

  def sub_nav
    if Rails.env.development?
      return Page.active.ordered.super_skinny.where(in_sub_nav: true)
    end
    Rails.cache.fetch("sub_nav", expires_in: 15.minutes) do
      Page.active.ordered.super_skinny.where(in_sub_nav: true)
    end
  end

  def sub_nav_li(kid, idx, len)
    last = len - 1 == idx
    title = last ? "#{kid.short_title}<i class='ico-search'></i>".html_safe : kid.short_title
    link = link_to title, kid.absolute_url, class: on_class(kid.absolute_url)
    klass = " class='search'" if last
    "<li#{klass}>#{link}</li>".html_safe
  end

  # Utility Helpers
  def email(e)
    e = e.strip.gsub(/@/, '/').gsub(/\./, '//')
    "<span class=\"e\">#{e}</span>".html_safe
  end

  def external_link(url, text="")
    if text == ""
      text = url.gsub('http://', '').gsub('https://', '').gsub('www.', '')
    end
    url = "http://#{url}" if url.index("http").blank?
    return "<a href='#{url}' class='external'>#{text}</a>".html_safe
  end

  def phone(p)
    p.strip.gsub(/-/, '.').gsub(/ /, '.')
  end

  def spaceless(text)
    text.gsub(' ', '&nbsp;').html_safe
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
