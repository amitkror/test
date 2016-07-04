class Profile::ProfileController < ApplicationController

  before_filter :authenticate_user!
  before_filter :confirm_guest_user

  layout "layouts/profile"

  def confirm_guest_user
    if current_user.from_guest_user? && !current_user.confirmed?
      redirect_to new_user_confirmation_path
    end
  end
end
