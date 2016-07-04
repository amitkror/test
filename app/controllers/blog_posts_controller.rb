class BlogPostsController < ApplicationController

	before_filter :set_archive_block, only: [:show, :index, :by_date, :by_category]

  before_filter :set_category_block, only: [:show, :index, :by_date, :by_category]

  caches_action :set_archive_block
  caches_action :set_category_block

  def index
    @blog_posts = []
    published_blogs = BlogPost.ordered.published
    @blog_posts << published_blogs

     # get city state  from reqest ip
    @city = request.location.city
    @state = request.location.state
    @blog_posts << published_blogs.where(["title like ? or tagline like ? or body like ?", "%#{@city}%", "%#{@city}%", "%#{@city}%"])
    @blog_posts << published_blogs.where(["title like ? or tagline like ? or body like ?", "%#{@state}%", "%#{@state}%", "%#{@state}%"])


    if current_user.present?
      audience_ids = current_user.audiences

      audience_ids.each do |audience|
        @blog_posts << published_blogs.joins(:audiences).where(:audiences => {:id => audience.id})
      end
      unless cookies[:signin_blogs].nil?
      cookies[:signin_blogs].split.uniq.each do |blog|
        @blog_posts << published_blogs.find_by_permalink(blog)
      end
    end
    else  
      unless cookies[:recent_blogs].nil?
        cookies[:recent_blogs].split.uniq.each do |blog|
          @blog_posts << published_blogs.find_by_permalink(blog)
        end
      end
    end
       
    @blog_posts.compact!
    @blog_posts.flatten!
    @blog_posts.reverse!
    @blog_posts.uniq!
    page = params[:page].to_i > 0 ? params[:page] : 1
    @blog_posts = @blog_posts.paginate(page: page, per_page: 10)
  
  end

  def feed
    #@blog_articles = BlogArticle.all
    @blog_posts = BlogPost.ordered.published
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def show
    unless user_signed_in? && !current_user.admin?
      @blog_post = BlogPost.active_or_hidden.find_by_permalink!(params[:id])
    else
      @blog_post = BlogPost.find_by_permalink!(params[:id])
      if @blog_post.unpublished?
        flash.now[:notice] = "You are viewing this because you are logged in."
      end
    end
  #   @blog_post = BlogPost.find_by_permalink!(params[:id])
    if user_signed_in? && current_user.verified?
      cookies[:signin_blogs] = ''  if cookies[:signin_blogs].nil?
      cookies[:signin_blogs] = cookies[:signin_blogs] + " " + "#{@blog_post.permalink}"
    else  
      cookies[:recent_blogs] = ''  if cookies[:recent_blogs].nil?
      cookies[:recent_blogs] = cookies[:recent_blogs] + " " + "#{@blog_post.permalink}"
    end
  end

  def by_date
    @blog_posts = BlogPost.ordered.by_month(params[:date])
      .published.paginate(page: params[:page] || 1, per_page: 10)
    render :index
  end

  def by_category
    @blog_posts = BlogPost.ordered.by_category(params[:category])
      .published.paginate(page: params[:page] || 1, per_page: 10)
    render :index
  end

  private

  def set_archive_block
  	dates = BlogPost.dates.all
  	list = {}
  	dates.each do |d|
  		month = d.created_at.month
  		year = d.created_at.year
  		if list[year].blank?
  			list[year] = [month]
  		else
  			list[year] << month if !list[year].include? month
  		end
  	end
  	list.each do |y, v|
  		list[y] = v.sort.reverse
  	end
  	@archive_block = list.sort.reverse
  end

  def set_category_block
    @tags = Tag.used
  end
end
