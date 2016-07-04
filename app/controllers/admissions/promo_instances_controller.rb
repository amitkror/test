class Admissions::PromoInstancesController < Admissions::AdmissionsController
  before_filter :set_promo_instance, except: [:index, :new, :create]
  before_filter :set_pages, only: [:new, :edit, :update, :create]
  load_resource find_by: :permalink
  authorize_resource

  def index
    @promo_instances = PromoInstance.unlocked.ordered
                                    .paginate page: params[:page], per_page: @per_page
  end

  def show
  end

  def new
    @promo_instance = PromoInstance.new
  end

  def create
    @promo_instance = PromoInstance.new(params[:promo_instance])
    if @promo_instance.save
      notice = promo_instance_flash(@promo_instance).html_safe
      redirect_to admin_promo_instances_path, notice: notice
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @promo_instance.update_attributes(params[:promo_instance])
      notice = promo_instance_flash(@promo_instance).html_safe
      redirect_to admin_promo_instances_path, notice: notice
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @promo_instance.destroy
    redirect_to admin_promo_instances_path,
                notice: "Successfully destroyed #{@promo_instance.title}."
  end

  private
    def set_promo_instance
      @promo_instance = PromoInstance.find_by_id!(params[:id])
    end

    def promo_instance_flash(promo_instance)
      render_to_string partial: "flash", locals: {
        promo_instance: promo_instance
      }
    end
end
