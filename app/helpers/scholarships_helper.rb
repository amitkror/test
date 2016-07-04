module ScholarshipsHelper

  def voting_class(submission_id)
    return "" unless user_signed_in?

    UserSubmissionVote.already_voted?(current_user.id, submission_id) ? " on" : ""
  end
end