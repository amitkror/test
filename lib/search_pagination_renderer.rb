#
# lib/search_pagination_renderer.rb
#
class SearchPaginationRenderer < WillPaginate::ActionView::LinkRenderer

  def prepare(collection, options, template)
    @link_path = options.delete(:link_path)
    super
  end

protected

  def url(page)
    @base_url_params ||= begin
      url_params = @base_url_params = Rack::Utils.parse_nested_query(@link_path)
      merge_optional_params(url_params)
    end

    url_params = @base_url_params.dup
    add_current_page_param(url_params, page)

    @template.url_for(url_params)
    page = super.gsub(".json", "")
  end
end