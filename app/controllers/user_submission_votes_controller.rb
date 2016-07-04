class UserSubmissionVotesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :setup_page

  def create

    unless UserSubmissionVote.already_voted?(current_user.id, @scholarship_submission.id)
      @user_submission_vote = UserSubmissionVote.new({ user: current_user, scholarship_submission: @scholarship_submission })
    else
      return render js: "alert('You have already voted for this entry.');"
    end

    if @user_submission_vote.save
      render
    else
      render js: "alert('Sorry, something went wrong and we couldn't cast your vote.');"
    end
  end

  def destroy
    @user_submission_vote = UserSubmissionVote.find_by_id!(params[:id])
    @user_submission_vote.destroy
  end

  protected
    def setup_page
      @scholarship = Scholarship.find_by_permalink!(params[:scholarship_id])
      @scholarship_submission = @scholarship.scholarship_submissions.selected.find_by_id!(params[:scholarship_submission_id])
    end

end
