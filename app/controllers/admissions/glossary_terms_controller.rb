class Admissions::GlossaryTermsController < Admissions::AdmissionsController
  before_filter :set_glossary_term, except: [:index, :new, :create]
  before_filter :expire_cache, only: [:create, :update, :destroy]

  load_resource find_by: :permalink
  authorize_resource

  def index
    @glossary_terms = GlossaryTerm.ordered.paginate page: params[:page], per_page: @per_page
  end

  def show
  end

  def new
    @glossary_term = GlossaryTerm.new
  end

  def create
    @glossary_term = GlossaryTerm.new(params[:glossary_term])
    if @glossary_term.save
      expire_glossary_cache
      redirect_to admin_glossary_terms_path,
        notice: glossary_term_flash(@glossary_term).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @glossary_term.update_attributes(params[:glossary_term])
      expire_glossary_cache
      redirect_to admin_glossary_terms_path,
        notice: glossary_term_flash(@glossary_term).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @glossary_term.destroy
    redirect_to admin_glossary_terms_path,
      notice: "Successfully destroyed #{@glossary_term.name}."
  end

  private
    def expire_cache
      expire_fragment('glossary')
    end

    def expire_glossary_cache
      page = Page.find_by_absolute_url("/glossary", select: "id")
      key = "page-#{page.id}"
      expire_fragment(key) if fragment_exist?(key)
    end

    def glossary_term_flash(glossary_term)
      render_to_string partial: "flash",
        locals: { glossary_term: glossary_term }
    end

    def set_glossary_term
      @glossary_term = GlossaryTerm.find_by_id!(params[:id])
    end
end
