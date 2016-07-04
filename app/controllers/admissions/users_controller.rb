class Admissions::UsersController < Admissions::AdmissionsController
  before_filter :set_user, only: [:show, :edit, :update, :confirm_destroy,
    :destroy]

  load_resource find_by: :permalink
  authorize_resource

  def index
    respond_to do |format|
      @status_id = params[:status_id]
      @role_id = params[:role_id]

      format.html {
        @order = params[:order]
        @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"

        @users = User.paginate(page: params[:page], per_page: @per_page)
          .includes(:system_avatar)

        unless @status_id.blank?
          @users = @users.where(status_id: @status_id)
        end

        unless @role_id.blank?
          @users = @users.where(role_id: @role_id)
        end

        unless @order.blank?
          @users = @users.order("#{@order} #{@dir}")
        else
          @users = @users.ordered
        end
      }

      format.csv {
        audiences = Audience.ordered
        newsletters = Newsletter.active.select("id, name")
        headers = User.header(audiences, newsletters)
        users = User.ordered

        unless @status_id.blank?
          users = users.where(status_id: @status_id)
        end

        unless @role_id.blank?
          users = users.where(role_id: @role_id)
        end

        #raise headers.inspect
#        send_data User.to_csv,
#                  type: 'text/csv; charset=iso-8859-1; header=present',
#                  disposition: "attachment; filename=users-#{DateTime.now}.csv"

        stream_csv("users-#{DateTime.now}.csv", CSV::Row.new(headers, headers, true)) do |rows|
          users.each do |user|
            rows << user.to_csv_row(headers, audiences, newsletters)
          end
        end
      }
    end
  end

  def show
  end

  def new
    @user = User.new
    @user.user_settings = UserSettings.new
    if params['utm']
      @partial_user = params['utm']
      @user.status_id = 2
      @user.role_id = 1
      @user.password = SecureRandom.hex(5).upcase
      @user.password_confirmation = @user.password      
    end    
  end  

  def create    
    @user = User.new(params[:user])    
    if params['utm']    
      usr_name = params[:user][:email][/[^@]+/]      
      @user.username = usr_name
      password = params[:user][:password]      
    end
    @user.skip_confirmation!
    if @user.save
      if params['utm']    
        QuestionMailer.delay(queue: 'questions').partial_user_welcome(@user, password)    
      end
      redirect_to admin_users_path, notice: user_flash(@user).html_safe
    else
      if params['utm']
        @partial_user = params['utm']
        @user.password = SecureRandom.hex(5).upcase
        @user.password_confirmation = @user.password
        @msg = 'Email has already been taken'            
      end
      render :new
    end
  end

  def edit
    @folders = @user.folders
    @bkmrks = @user.bookmarks.pluck(:resource_id)
    @resources = Resource.find(@bkmrks)
  end

  def update
    if @user.update_attributes(params[:user])
      @user.clear_audiences if params[:user][:audience_ids].blank?
      @user.clear_newsletters if params[:user][:newsletter_ids].blank?
      redirect_to admin_users_path, notice: user_flash(@user).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "Successfully destroyed #{@user.full_name}."
  end

  def search
    users = User.super_skinny.admin_or_verified.where("username ILIKE ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json {
        render json: users.map{ |resource| {
          name: resource.username,
          id: resource.id,
        }}
      }
    end
  end

  private
    def set_user
      @user = User.find_by_id!(params[:id])
    end

    def user_flash(user)
      render_to_string partial: "flash", locals: { user: user }
    end
end
