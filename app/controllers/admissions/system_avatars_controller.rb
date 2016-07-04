class Admissions::SystemAvatarsController < Admissions::AdmissionsController
  before_filter :set_system_avatar, except: [:index, :new, :create]
  load_resource find_by: :permalink
  authorize_resource

  def index
    @system_avatars = SystemAvatar.ordered.paginate page: params[:page], per_page: @per_page
  end

  def show
  end

  def new
    @system_avatar = SystemAvatar.new
  end

  def create
    @system_avatar = SystemAvatar.new(params[:system_avatar])
    if @system_avatar.save
      redirect_to admin_system_avatars_path,
        notice: system_avatar_flash(@system_avatar).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @system_avatar.update_attributes(params[:system_avatar])
      redirect_to admin_system_avatars_path,
        notice: system_avatar_flash(@system_avatar).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @system_avatar.destroy
    redirect_to admin_system_avatars_path,
      notice: "Successfully destroyed #{@system_avatar.name}."
  end

  private
    def set_system_avatar
      @system_avatar = SystemAvatar.find_by_id!(params[:id])
    end

    def system_avatar_flash(system_avatar)
      render_to_string partial: "flash",
        locals: { system_avatar: system_avatar }
    end
end
