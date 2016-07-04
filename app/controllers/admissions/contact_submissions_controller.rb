class Admissions::ContactSubmissionsController < Admissions::AdmissionsController

  before_filter :set_contact_submission, only: [:show, :destroy]
  load_resource find_by: :permalink
  authorize_resource

  def index
    @contact_submissions = ContactSubmission.ordered.paginate(
      page: params[:page], per_page: @per_page)
  end

  def show
    @contact_submission = ContactSubmission.find_by_id!(params[:id])
  end

  def destroy
    @contact_submission.destroy
    message = "Destroyed submission from #{@contact_submission.name}."
    respond_to do |format|
      format.html {
        redirect_to admin_contact_submissions_path, notice: message
      }
      format.js {
        flash[:notice] = message
        render js: "window.parent.location='#{admin_contact_submissions_path}';"
      }
    end
  end

  private
    def set_contact_submission
      @contact_submission = ContactSubmission.find_by_id!(params[:id])
    end
end
