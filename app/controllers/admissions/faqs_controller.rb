class Admissions::FaqsController < Admissions::AdmissionsController
  before_filter :set_faq, except: [:index, :new, :create]
  before_filter :expire_cache, only: [:create, :update, :destroy]

  load_resource find_by: :permalink
  authorize_resource

  def index
    respond_to do |format|
      format.html {
        @faqs = Faq.ordered.paginate page: params[:page], per_page: @per_page
      }
      format.csv {
        send_data Faq.to_csv,
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: "attachment; filename=faqs-#{DateTime.now}.csv"
      }
    end
  end

  def show
  end

  def new
    @faq = Faq.new
  end

  def create
    @faq = Faq.new(params[:faq])
    if @faq.save
      redirect_to admin_faqs_path,
        notice: faq_flash(@faq).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @faq.update_attributes(params[:faq])
      @faq.clear_audiences if params[:faq][:audience_ids].blank?
      redirect_to admin_faqs_path,
        notice: faq_flash(@faq).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @faq.destroy
    redirect_to admin_faqs_path,
      notice: "Successfully destroyed #{@faq.question}."
  end

  private
    def expire_cache
      expire_fragment('faqs')
    end

    def set_faq
      @faq = Faq.find_by_id!(params[:id])
    end

    def faq_flash(faq)
      render_to_string partial: "flash",
        locals: { faq: faq }
    end
end
