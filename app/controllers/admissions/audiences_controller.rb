class Admissions::AudiencesController < Admissions::AdmissionsController
  before_filter :set_audience, except: [:index, :new, :create]

  load_resource find_by: :permalink
  authorize_resource

  def index
    @audiences = Audience.ordered.paginate page: params[:page], per_page: @per_page
  end

  def show
  end

  def new
    @audience = Audience.new
  end

  def create
    @audience = Audience.new(params[:audience])
    if @audience.save
      redirect_to admin_audiences_path,
        notice: audience_flash(@audience).html_safe
    else
      render :new
    end
  end

  def edit
    @newsletter = @audience.newsletter
  end

  def update
    if @audience.update_attributes(params[:audience])
      redirect_to admin_audiences_path,
        notice: audience_flash(@audience).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @audience.destroy
    redirect_to admin_audiences_path,
      notice: "Successfully destroyed #{@audience.name}."
  end

  private
    def set_audience
      @audience = Audience.find_by_id!(params[:id])
    end

    def audience_flash(audience)
      render_to_string partial: "flash",
        locals: { audience: audience }
    end
end
