class Profile::ContestsController < Profile::ProfileController

  # before_filter :ensure_adviser!

  def index
    @contests = Contest.where(is_active: true)
  end

  private

  # Use if we go back to needing only advisers and verified users to use this
  def ensure_adviser!
    unless current_user.verified? || current_user.is_adviser
      redirect_to root_url
    end
  end
end
