class GuestQuestionsController < ApplicationController
  def redirect
    if current_user
      redirect_to new_profile_question_path
    else
      redirect_to new_guest_profile_guest_question_path
    end
  end
end
