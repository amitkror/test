class Admissions::ScholarshipSubmissionsController < Admissions::AdmissionsController

  before_filter :set_scholarship_submission, except: [:index, :new, :create]
  load_resource find_by: :permalink
  authorize_resource

  def index
    @scholarship_id = params[:scholarship_id]

    respond_to do |format|
      format.html {
        @order = params[:order]
        @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"

        @submissions = ScholarshipSubmission.paginate( page: params[:page],
                  per_page: @per_page).includes(:scholarship)

        unless @scholarship_id.blank?
          @submissions = @submissions.where(scholarship_id: @scholarship_id)
        end

        unless @order.blank?
          @submissions = @submissions.order("#{@order} #{@dir}")
        else
          @submissions = @submissions.ordered
        end
      }
      format.csv {
        send_data ScholarshipSubmission.to_csv(request.host_with_port, @scholarship_id),
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: "attachment; filename=scholarship_submissions-#{DateTime.now}.csv"
      }
    end
  end

  def show
  end

  def new
    @scholarship_submission = ScholarshipSubmission.new
  end

  def create
    @scholarship_submission = ScholarshipSubmission.new(params[:scholarship_submission])
    if @scholarship_submission.save
      redirect_to admin_scholarship_submissions_path,
        notice: scholarship_submission_flash(@scholarship_submission).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @scholarship_submission.update_attributes(params[:scholarship_submission])
      redirect_to admin_scholarship_submissions_path,
        notice: scholarship_submission_flash(@scholarship_submission).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @scholarship_submission.destroy
    redirect_to admin_scholarship_submissions_path,
      notice: "Successfully destroyed #{@scholarship_submission.full_name}."
  end

  private

    def scholarship_submission_flash(scholarship_submission)
      render_to_string partial: "flash",
        locals: {
          scholarship_submission: scholarship_submission
        }
    end

    def set_scholarship_submission
      @scholarship_submission = ScholarshipSubmission.find_by_id!(params[:id])
    end
end
