class ScholarshipSubmissionsController < ScholarshipsController

  def create
    @scholarship = Scholarship.find_by_permalink!(params[:scholarship_id])

    authenticate_user! if @scholarship.require_authentication

    @scholarship_submission = ScholarshipSubmission.new(params[:scholarship_submission])
    @scholarship_submission.scholarship_id = @scholarship.id

    if @scholarship_submission.save
      redirect_to scholarship_path(@scholarship), notice: @scholarship.thank_you
    else
      render 'scholarships/show'
    end
  end

  def show
    @scholarship = Scholarship.find_by_permalink!(params[:scholarship_id])
    @scholarship_submission = @scholarship.scholarship_submissions.selected.find_by_id!(params[:id])

    @voted = user_signed_in? && UserSubmissionVote.already_voted?(current_user.id, @scholarship_submission.id)

    unless @voted
      @user_submission_vote = UserSubmissionVote.new
    else
      @user_submission_vote = UserSubmissionVote.find_by_user_and_submission(current_user.id, @scholarship_submission.id)
    end
    render layout: 'layouts/popup'
  end
end
