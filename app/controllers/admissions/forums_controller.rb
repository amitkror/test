class Admissions::ForumsController < Admissions::AdmissionsController
  before_filter :set_forum, except: [:index, :new, :create]

  load_resource find_by: :permalink
  authorize_resource

  def index
    @forums = Forum.ordered.paginate page: params[:page], per_page: @per_page
  end

  def show
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      redirect_to admin_forums_path,
        notice: forum_flash(@forum).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @forum.update_attributes(params[:forum])
         @forum.clear_audiences if params[:forum][:audience_ids].blank?
      redirect_to admin_forums_path,
        notice: forum_flash(@forum).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @forum.destroy
    redirect_to admin_forums_path,
      notice: "Successfully destroyed #{@forum.name}."
  end

  private
    def set_forum
      @forum = Forum.find_by_permalink!(params[:id])
    end

    def forum_flash(forum)
      render_to_string partial: "flash",
        locals: { forum: forum }
    end
end
