class Admissions::PhasesController < Admissions::AdmissionsController
  before_filter :set_phase, except: [:index, :new, :create]
  before_filter :set_pages, only: [:new, :edit, :update, :create]
  load_resource find_by: :permalink
  authorize_resource

  def index
    @phases = Phase.ordered.paginate page: params[:page], per_page: @per_page
  end

  def show
  end

  def new
    @phase = Phase.new
  end

  def create
    @phase = Phase.new(params[:phase])
    if @phase.save
      redirect_to admin_phases_path,
        notice: phase_flash(@phase).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @phase.update_attributes(params[:phase])
      redirect_to admin_phases_path,
        notice: phase_flash(@phase).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @phase.destroy
    redirect_to admin_phases_path,
      notice: "Successfully destroyed #{@phase.name}."
  end

  private
    def set_phase
      @phase = Phase.find_by_id!(params[:id])
    end

    def phase_flash(phase)
      render_to_string partial: "flash",
        locals: { phase: phase }
    end
end
