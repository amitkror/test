class Admissions::BlogPostsController < Admissions::AdmissionsController

  before_filter :set_post, only: [:edit, :update, :confirm_destroy, :destroy]

  load_resource find_by: :permalink
  authorize_resource

	def index
    # authorize! :index, @posts
    # @posts = BlogPost.roots.super_skinny.ordered
    if params[:keyword_search] && !params[:keyword_search].blank?
      @keyword_str = params[:keyword_search]
      keywords = params[:keyword_search].strip.split
      if keywords.size != 1
        @posts = Array.new
        keywords.each_with_index do |keyword,index|          
          @posts << BlogPost.where(["title like ? or tagline like ? or body like ? or meta_title like ? or meta_keywords like ? or meta_description like ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"]).order("created_at DESC")
        end        
      else        
        @keyword = params[:keyword_search].downcase
        @posts = BlogPost.where(["permalink like ? or tagline like ? or body like ? or meta_title like ? or meta_keywords like ? or meta_description like ?", "%#{@keyword}%", "%#{@keyword_str}%", "%#{@keyword_str}%", "%#{@keyword_str}%", "%#{@keyword_str}%", "%#{@keyword_str}%"]).order("created_at DESC").paginate(page: params[:page], per_page: @per_page || params[:per_page])
      end        
    else
      @posts = BlogPost.paginate(page: params[:page], per_page: @per_page || params[:per_page])
    end    
    # @tag = Tag.new#so we can admin tags

    @order = params[:order]
    @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"
    @status_id = params[:status_id]

    unless @status_id.blank?
      @posts = @posts.where(status_id: @status_id)
    end

    unless @order.blank?
      @posts = @posts.order("#{@order} #{@dir}")
    else      
      if @posts.class.to_s == 'Array'
        @posts = @posts.flatten.uniq        
        @posts = @posts.paginate(page: params[:page], per_page: @per_page || params[:per_page])
      else
        @posts = @posts.ordered
      end  
    end

  end

  def show

  end

  def new
    # authorize! :new, @blog_post
    @blog_post = BlogPost.new
    render :new
  end

  def create
    # authorize! :create, @blog_post
    @blog_post = BlogPost.new(params[:blog_post])

    # @blog_post.build_tag_taggables

    @blog_post.user = current_user

    if @blog_post.save
      redirect_to admin_blog_posts_path, notice: "Post Saved."
    else
      render :new, notice: "Sorry, something went wrong."
    end
  end

  def edit
    # authorize! :edit, @blog_post
  end

  def update
    # authorize! :update, @blog_post
    if params[:clear_image] == "true"
      @blog_post.image = nil
    end

    if @blog_post.update_attributes(params[:blog_post])
       @blog_post.clear_audiences if params[:blog_post][:audience_ids].blank?
      redirect_to admin_blog_posts_path
    else
      flash[:error] = "Sorry, something went wrong."
      render :edit
    end
  end

  def update_order

  end

  def confirm_destroy
  end

  def destroy
    # authorize! :destroy, @blog_post
    @blog_post.destroy
    redirect_to admin_blog_posts_path,
      notice: "Successfully destroyed #{@blog_post.title}."
  end

  private

  def set_post
    @blog_post = BlogPost.find_by_permalink!(params[:id])
  end

  def authorize
  end

end
