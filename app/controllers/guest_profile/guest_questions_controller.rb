class GuestProfile::GuestQuestionsController < GuestProfile::GuestProfileController
  include Rack::Recaptcha::Helpers
  before_filter :check_user

  def index
    if params[:secret_code]
      @guest_question = GuestQuestion.new
      @guest_user = GuestUser.where(secret_code: params[:secret_code]).first
      @guest_questions = @guest_user.guest_questions
    else
      redirect_to new_guest_profile_guest_question_path
    end
  end

  def new
    if current_user
      redirect_to new_profile_question_path
    end

    @guest_email = session[:guest_email]
    @guest_zipcode = session[:guest_zipcode]

    @guest_question = GuestQuestion.new
  end

  def create
    question_params = params[:guest_question]
    guest_user_params = params[:guest_user]

    session[:guest_email] = guest_user_params[:email]
    session[:guest_zipcode] = guest_user_params[:zipcode]

    if guest_user_params[:email].blank? || guest_user_params[:zipcode].blank?
      return render :new
    end

    # return render :new if User.find_by_email(guest_user_params[:email])
    if User.find_by_email(guest_user_params[:email])
      user = User.find_by_email(guest_user_params[:email])
      guest_question = user.questions.new(question_params)

      if !recaptcha?
        @guest_question = GuestQuestion.new(question_params)
        return render :new
      end

      if guest_question.save
        session[:user_exists] = true
        QuestionMailer.delay(queue: 'questions').send_to_admins(@guest_question)
        redirect_to success_guest_profile_guest_questions_path
      else
        @guest_question = GuestQuestion.new(question_params)
        render :new
      end

      return
    end

    if GuestUser.find_by_email(guest_user_params[:email])
      @guest_user = GuestUser.find_by_email(guest_user_params[:email])
    else
      @guest_user = GuestUser.create(guest_user_params)
    end

    session[:guest_user_id] = @guest_user.id

    @guest_question = @guest_user.guest_questions.new(question_params)

    return render :new if !recaptcha?

    if @guest_question.save

      QuestionMailer.delay(queue: 'questions').send_to_admins(@guest_question)

      redirect_to success_guest_profile_guest_questions_path
    else
      render :new
    end
  end

  def build
    @guest_question = GuestQuestion.new
    
    if request.post?
      question_params = params[:guest_question]
      guest_user_params = params[:guest_user]

      session[:guest_email] = guest_user_params[:email]
      session[:guest_zipcode] = guest_user_params[:zipcode]

      if guest_user_params[:email].blank? || guest_user_params[:zipcode].blank?
        return render :new
      end

      # return render :new if User.find_by_email(guest_user_params[:email])
      if User.find_by_email(guest_user_params[:email])
        user = User.find_by_email(guest_user_params[:email])
        guest_question = user.questions.new(question_params)

        if guest_question.save
          session[:user_exists] = true
          QuestionMailer.delay(queue: 'questions').send_to_admins(@guest_question)
          redirect_to success_guest_profile_guest_questions_path
        else
          @guest_question = GuestQuestion.new(question_params)
          render :new
        end

        return
      end

      if GuestUser.find_by_email(guest_user_params[:email])
        @guest_user = GuestUser.find_by_email(guest_user_params[:email])
      else
        @guest_user = GuestUser.create(guest_user_params)
      end

      session[:guest_user_id] = @guest_user.id

      @guest_question = @guest_user.guest_questions.new(question_params)

      return render :new if !recaptcha?

      if @guest_question.save

        QuestionMailer.delay(queue: 'questions').send_to_admins(@guest_question)

        redirect_to success_guest_profile_guest_questions_path
      else
        render :new
      end
    end  
  end  

  def show
    if current_user
      @guest_question = current_user.adviser_guest_questions.find_by_id!(params[:id])
      @guest_question.mark_read current_user
    elsif params[:secret_code]
      @guest_user = GuestUser.where(secret_code: params[:secret_code]).first
      session[:guest_user_id] = @guest_user.id
      @guest_question = @guest_user.guest_questions.find_by_id!(params[:id])
      @guest_question.mark_read @guest_user
    else
      redirect_to new_user_session_path
    end
  end

  def success
    if current_user
      redirect_to new_profile_question_path
    end

    @user_exists = session[:user_exists].blank? ? false : true
    session[:user_exists] = nil

    if params[:secret_code]
      @guest_user = GuestUser.where(secret_code: params[:secret_code]).first
      @guest_questions = @guest_user.guest_questions
    end
  end

  def recaptcha?
    if !recaptcha_valid?
      flash.now[:alert] = "There was an error with the recaptcha code. Please re-enter the code below."
      return false
    end

    true
  end

  private 
    def check_user
      if current_user.present?
        self.class.layout "layouts/profile"
      else
        self.class.layout "layouts/application"
      end  
    end  
end
