class Admissions::PagesController < Admissions::AdmissionsController

  before_filter :set_page, only: [:edit, :update, :confirm_destroy, :destroy,]
  load_resource find_by: :permalink
  authorize_resource

  def index
    @pages = Page.roots.super_skinny.ordered
  end

  def show
  end

  def new
    @page = Page.new
    set_pages
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      expire_page_cache(@page)
      redirect_to admin_pages_path, notice: page_flash(@page).html_safe
    else
      set_pages
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update_attributes(params[:page])
      unless request.xhr?
        expire_page_cache(@page)
        redirect_to admin_pages_path, notice: page_flash(@page).html_safe
      else
        render json: { success: true }
      end
    else
      render :edit
    end
  end

  def update_order
    begin
      Page.update_tree JSON.parse(params[:pages])
      render json: { success: true }
    rescue
      render json: { success: false }
    end
  end

  def confirm_destroy
  end

  def destroy
    @page.destroy
    redirect_to admin_pages_path,
                notice: "Successfully destroyed #{@page.title}."
  end

  private
    def expire_page_cache(page)
      key = "page-#{page.id}"
      expire_fragment(key) if fragment_exist?(key)
    end

    def page_flash(page)
      render_to_string partial: "flash", locals: { page: page }
    end

    def set_page
      @page = Page.find_by_permalink!(params[:id])
      @pages = ancestry_options(Page.exclude(@page.id).scoped\
          .arrange(order: 'pages.order, pages.title')) {|i|
            "#{'-' * i.depth} #{i.short_title}"
          }
    end
end
