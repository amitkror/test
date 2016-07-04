class SessionsController < Devise::SessionsController

  before_filter :check_user, only: [:success]

  # POST /resource/sign_in
  def create
    guest_user = GuestUser.find_by_email(resource_params[:login])

    if guest_user
      flash.now[:alert] = 'Oops, your account hasnt been activated yet. Please <a href="/users/register/signup">Sign Up</a> first!'
      return render :new
    end

    user = User.find_by_email(resource_params[:login])
    if user    
     if(user.failed_attempts != 0 && user.failed_attempts % 3 == 0)      
      random_token = SecureRandom.urlsafe_base64(nil, false)
      user.reset_password_token   = random_token
      user.reset_password_sent_at = Time.now.utc
      user.save(validate: false)
      @alert_msg = ''
      @alert_msg = 'alert'
      QuestionMailer.delay(queue: 'questions').automated_password_recovery(user)    
      return render :new
     end
    end

    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    respond_to do |format|
      format.html {
        respond_with resource, :location => after_sign_in_path_for(resource)
      }
      format.js {
        render
      }
    end
  end

  def new
    if session[:guest_email]
      @guest_email = User.find_by_email(session[:guest_email]).blank? ? '' : session[:guest_email]
    end

    unless request.referrer.blank? || request.xhr?
      
      url = request.referrer

      # 
      # This fixes sifter #14631 but if it needs to happen again
      # consider fixing globally.
      # 
      # The problem is that the referrer value does not change when
      # bounced through the 401 unauthorized.
      url = (URI(url).path == '/profile/ask-an-adviser') ? '/profile/ask-an-adviser/new' : url

      logger.error "\n\n +++#{url}\n\n"
      unless URI(url).path.starts_with?("/login")
        # Let's just keep devise out of this, okay?
        session[:user_return_to] = url
      end
    end

    super
  end

end
