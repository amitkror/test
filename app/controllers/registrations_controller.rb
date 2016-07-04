class RegistrationsController < Devise::RegistrationsController
  include Rack::Recaptcha::Helpers

  before_filter :check_user, only: [:success]

  layout false, only: [:success]

  def new
    if session[:guest_user_id]
      guest_user = GuestUser.find(session[:guest_user_id])
      guest_params = guest_user.attributes.slice('email', 'zipcode')
      @user = User.new(guest_params)
    else
      @user = User.new
    end

    @contest_copy = false
    if params[:ref]
      @contest_copy = true
      cookies.signed[:advisorref] = { value: params[:ref], expires: 24.hours.from_now }
    end
  end

  def create
    if recaptcha_valid?
      super
    else
      build_resource
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code. Please re-enter the code below."
      flash.delete :recaptcha_error
      render :new
    end
  end

  def success
    # Referral check/create
    if cookies[:advisorref]
      ref_code = ReferralCode.find_by_code(cookies.signed[:advisorref])

      if ref_code
        contest = ref_code.contest
        user = User.find(ref_code.user_id)
      end
      
      unless !contest || Referral.find_by_referred_id(current_user.id) || DateTime.now.to_date > contest.end_date
        Referral.create({ referrer_id: ref_code.user_id, contest_id: ref_code.contest_id, referred_id: current_user.id })
        user.send_raffle?(contest)
      end
    end

    step = params[:step].blank? ? 0 : params[:step].to_i
    if step.is_a?(Integer) && [1, 2].include?(step)
      @form = "step#{step}"
    else
      raise ActiveRecord::RecordNotFound
    end

    if request.put?

      if current_user.update_attributes(params[:user])

        if step == 1
          return redirect_to registration_success_path(2)
        else
          return redirect_to profile_root_path
        end
      else
        raise "Error saving user"
      end
    end

    @page = Page.find_by_absolute_url!("/registrations/success",
        select: "id, title, meta_description, teaser, copy")

  end

  private
    def check_user
      redirect_to "/" if current_user.blank?
    end

  protected

  def after_sign_up_path_for(resource)
    registration_success_path(1)
  end

  def after_inactive_sign_up_path_for(resource)
    registration_success_path(1)
  end
end
