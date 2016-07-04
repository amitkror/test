class SearchController < ApplicationController

  layout 'layouts/no_search'

  def index

    q = params[:q] || ""

    q = "" if q == "Search hand-picked resources for getting into and staying in college"

    if request.post?
      search_form = SearchForm.new(params[:search_form])
      search_form.q = q
      # Check if it's a post. If it is, normalize the URL and do a redirect.
      return redirect_to "/search?#{search_form.params.to_query}"
    elsif request.xhr?
      search_form = SearchForm.new(params[:search_form])
      search_form.q = q
    else
      search_form = SearchForm.new({
        q: q,
        audience_ids: blank_or_split(:aud),
        borough_ids: blank_or_split(:bor),
        language_ids: blank_or_split(:lang),
        popular_ids: blank_or_split(:pop),
        subject_ids: blank_or_split(:sub),
        type: (params[:type].blank? ? nil : params[:type].to_i),
        org: (params[:org].blank? ? nil : params[:org].to_i),
        phase_id: (params[:phase_id].blank? ? nil : params[:phase_id].to_i),
      })
    end

    @link_path = search_form.params.to_query

    @results = Resource.search do

      fulltext search_form.q do
        boost_fields name: 2.0
        boost_fields keywords: 2.0
      end

      order_by :sort_name if search_form.q.blank?

      with(:type_id, search_form.type) unless search_form.type.blank?
      with(:organization_id, search_form.org) unless search_form.org.blank?

      unless search_form.phase_id.blank?
        any_of do
          with(:phase_ids, search_form.phase_id)
        end
      end

      any_of do
        search_form.audience_ids.each do |id|
          with(:audience_ids, id)
        end
      end

      any_of do
        search_form.borough_ids.each do |id|
          with(:borough_ids, id)
        end
      end

      any_of do
        search_form.language_ids.each do |id|
          with(:language_ids, id)
        end
      end

      any_of do
        search_form.popular_ids.each do |id|
          with(:popular_ids, id)
        end
      end

      any_of do
        search_form.subject_ids.each do |id|
          with(:subject_ids, id)
        end
      end

      page = params[:page].to_i > 0 ? params[:page] : 1
      paginate page: page, per_page: 20
    end

    # search for other resources
    @keyword_str = params[:q]    
    
    respond_to do |format|
      format.html {

        tab_hash = params.clone
        tab_hash.delete :type
        tab_hash.delete :action
        tab_hash.delete :controller
        tab_hash.delete :page

        @tab_path = tab_hash.to_query
        @page = Page.find_by_absolute_url!("/search")
        @search_form = search_form
      }
      format.json {
        render json: {
          success: true,
          has_results: !@results.hits.empty?,
          link_path: @link_path,
          total: @results.total,
          results: render_to_string(
            action: "_results",
            layout: false,
            formats: [:html],
            locals: {
              link_path: @link_path,
              results: @results,
            }),
        }
      }
    end
  end

  def global_search
    q = params[:q] || ""

    q = "" if q == "Search hand-picked resources for getting into and staying in college"

    @keyword_str = params[:q]
    keywords = params[:q].strip.split    
    array = Array.new
    
    if keywords.size != 1
      keywords.each_with_index do |keyword,index|
        array << BlogPost.where(["title like ? or tagline like ? or body like ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"]).order("updated_at DESC")
        array << Event.where(["name like ? or body like ?", "%#{keyword}%", "%#{keyword}%"]).order("updated_at DESC")
        array << Faq.where(["question like ? or answer like ?", "%#{keyword}%", "%#{keyword}%"]).order("updated_at DESC")
        array << ForumThread.where(["name like ? or message like ? ", "%#{keyword}%", "%#{keyword}%"]).order("updated_at DESC")
        array << Scholarship.where(["name like ? or copy like ? or logged_in_copy like ? or meta_description like ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"]).order("updated_at DESC")
        array << Resource.where(["name like ? or body like ? or teaser like ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"]).order("updated_at DESC")
      end      
      @array = array.flatten.uniq
      #@array = @array.sort_by(&:updated_at)
      @array = @array.sort!{|a,b|a.updated_at <=> b.updated_at}      
      @array = @array.reverse
      @size = @array.size
    else
      @search_blogposts = BlogPost.where(["title like ? or tagline like ? or body like ?", "%#{@keyword_str}%", "%#{@keyword_str}%", "%#{@keyword_str}%"]).order("updated_at DESC")    
      @search_events = Event.where(["name like ? or body like ?", "%#{@keyword_str}%", "%#{@keyword_str}%"]).order("updated_at DESC")    
      @search_faqs = Faq.where(["question like ? or answer like ?", "%#{@keyword_str}%", "%#{@keyword_str}%"]).order("updated_at DESC")
      @search_forum_threads = ForumThread.where(["name like ? or message like ? ", "%#{@keyword_str}%", "%#{@keyword_str}%"]).order("updated_at DESC")
      @search_scholarships = Scholarship.where(["name like ? or copy like ? or logged_in_copy like ? or meta_description like ?", "%#{@keyword_str}%", "%#{@keyword_str}%", "%#{@keyword_str}%", "%#{@keyword_str}%"]).order("updated_at DESC")
      @search_resources = Resource.where(["name like ? or body like ? or teaser like ?", "%#{@keyword_str}%", "%#{@keyword_str}%", "%#{@keyword_str}%"]).order("updated_at DESC")

      array << @search_blogposts    
      array << @search_events
      array << @search_faqs
      array << @search_forum_threads
      array << @search_scholarships
      array << @search_resources

      @array = array.flatten
      #@array = @array.sort_by(&:updated_at)
      @array = @array.sort!{|a,b|a.updated_at <=> b.updated_at}
      @array = @array.reverse
      @size = @array.size
    end          

    tab_hash = params.clone
    tab_hash.delete :type
    tab_hash.delete :action
    tab_hash.delete :controller
    tab_hash.delete :page

    @tab_path = tab_hash.to_query
    @page = Page.find_by_absolute_url!('/search')
    
    @search_form = SearchForm.new({
      q: q,
      audience_ids: blank_or_split(:aud),
      borough_ids: blank_or_split(:bor),
      language_ids: blank_or_split(:lang),
      popular_ids: blank_or_split(:pop),
      subject_ids: blank_or_split(:sub),
      type: (params[:type].blank? ? nil : params[:type].to_i),
      org: (params[:org].blank? ? nil : params[:org].to_i),
      phase_id: (params[:phase_id].blank? ? nil : params[:phase_id].to_i),
    })
    
    @search_form.q = q
    @link_path = @search_form.params.to_query

    page = params[:page].to_i > 0 ? params[:page] : 1
    @array = @array.paginate(:page => page, :per_page => 20)
  end

  private
    def blank_or_split(key)
      params[key].blank? ? [] : params[key].split(',').map(&:to_i)
    end
end
