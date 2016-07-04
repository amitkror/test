class ForumsController < ApplicationController
  before_filter :set_page

  def index
    @forums = []
    active_forums = Forum.active
    @forums << active_forums

    @city = request.location.city
    @state = request.location.state
    city_forums = ForumThread.where(["name like ? or message like ? ", "%#{@city}%", "%#{@city}%"]).pluck(:forum_id).uniq! 
    state_forums = ForumThread.where(["name like ? or message like ? ", "%#{@state}%", "%#{@state}%"]).pluck(:forum_id).uniq!
    
    unless city_forums.empty?
      city_forums.each do |id|
        @forums << active_forums.find(id)
      end 
    end

    unless state_forums.empty?
      state_forums.each do |id|
        @forums << active_forums.find(id)
      end 
    end

    if current_user.present?
      audience_ids = current_user.audiences

      audience_ids.each do |audience|
        @forums << active_forums.joins(:audiences).where(:audiences => {:id => audience.id})
      end

      unless cookies[:signin_forum].nil? 
        cookies[:signin_forum].split.uniq.each do |id|
          @forums << active_forums.find_by_permalink(id)
        end
      end
    else
      @forums << active_forums.ordered
      unless cookies[:recent_forum].nil? 
        cookies[:recent_forum].split.uniq.each do |id|
          @forums << active_forums.find_by_permalink(id)
        end
      end
    end

    @forums.compact!
    @forums.flatten!
    @forums.reverse!
    @forums.uniq!
    @forums
  end

  def show

    unless user_signed_in? && !current_user.admin?
      @forum = Forum.active_or_hidden.find_by_permalink!(params[:id])
    else
      @forum = Forum.find_by_permalink!(params[:id])
      if @forum.unpublished?
        flash.now[:notice] = "You are viewing this because you are logged in."
      end
    end
    
    @forum_threads = @forum.recent_forum_threads.paginate(page: params[:page])
    
    if user_signed_in? && current_user.verified?
      cookies[:signin_forum] = ''  if cookies[:signin_forum].nil?
      cookies[:signin_forum] = cookies[:signin_forum] + " " + "#{@forum.permalink}"
    else  
      cookies[:recent_forum] = ''  if cookies[:recent_forum].nil?
      cookies[:recent_forum] = cookies[:recent_forum] + " " + "#{@forum.permalink}"
    end 

  end

  def search
    query = params[:q] || ""

    if request.post?
      ps = {}
      ps = { q: CGI.escape(query) } unless query.blank?
      return redirect_to "/forums/search?#{ps.to_query}"
    end
    @query = query
    @search = Sunspot.search(ForumThread) do
      fulltext query do
        boost_fields name: 2.0
      end
      paginate page: params[:page] || 1
    end
  end

  private
    def set_page
      @page = Page.find_by_absolute_url!("/forums",
        select: "id, title, meta_description, teaser, copy")
    end
end