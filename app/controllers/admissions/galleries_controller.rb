class Admissions::GalleriesController < Admissions::AdmissionsController
  before_filter :set_gallery, except: [:index, :new, :create, :browse]

  load_resource find_by: :permalink
  authorize_resource

  def index
    @galleries = Gallery.ordered.paginate page: params[:page], per_page: @per_page
  end

  def show
  end

  def new
    @gallery = Gallery.new
    @popup = params[:popup]
    render layout: 'admissions/layouts/popup' if @popup == 'true'
  end

  def create
    @gallery = Gallery.new(params[:gallery])
    if @gallery.save
      popup = params[:form][:popup] == 'true'
      @gallery.update_asset_order(params[:gallery][:asset_tokens])
      return redirect_to browse_admin_galleries_path if popup
      redirect_to admin_galleries_path, notice: gallery_flash(@gallery).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @gallery.update_attributes(params[:gallery])
      @gallery.update_asset_order(params[:gallery][:asset_tokens])
      redirect_to admin_galleries_path, notice: gallery_flash(@gallery).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @gallery.destroy
    redirect_to admin_galleries_path,
                notice: "Successfully destroyed #{@gallery.title}."
  end

  def browse
    @tiny = params[:tiny] == 'true'
    @galleries = Gallery.recent.paginate page: params[:page], per_page: 49
    render layout: 'admissions/layouts/popup'
  end

  private
    def set_gallery
      @gallery = Gallery.find_by_id!(params[:id])
    end

    def gallery_flash(gallery)
      render_to_string partial: "flash", locals: { gallery: gallery }
    end
end
