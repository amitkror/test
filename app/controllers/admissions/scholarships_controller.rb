class Admissions::ScholarshipsController < Admissions::AdmissionsController

  before_filter :set_scholarship, except: [:index, :new, :create]
  load_resource find_by: :permalink
  authorize_resource

  def index

    respond_to do |format|
      format.html {
        @order = params[:order]
        @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"

        @scholarships = Scholarship.paginate page: params[:page],
          per_page: @per_page

        unless @order.blank?
          @scholarships = @scholarships.order("#{@order} #{@dir}")
        else
          @scholarships = @scholarships.ordered
        end
      }
      format.csv {
        send_data Scholarship.to_csv(request.host_with_port),
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: "attachment; filename=scholarships-#{DateTime.now}.csv"
      }
    end
  end

  def show
  end

  def new
    @scholarship = Scholarship.new
  end

  def create
    @scholarship = Scholarship.new(params[:scholarship])
    if @scholarship.save
      redirect_to admin_scholarships_path,
        notice: scholarship_flash(@scholarship).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @scholarship.update_attributes(params[:scholarship])
      @scholarship.clear_audiences if params[:scholarship][:audience_ids].blank?
      redirect_to admin_scholarships_path,
        notice: scholarship_flash(@scholarship).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @scholarship.destroy
    redirect_to admin_scholarships_path,
      notice: "Successfully destroyed #{@scholarship.name}."
  end

  private

    def scholarship_flash(scholarship)
      render_to_string partial: "flash", locals: { scholarship: scholarship }
    end

    def set_scholarship
      @scholarship = Scholarship.find_by_permalink!(params[:id])
    end
end
