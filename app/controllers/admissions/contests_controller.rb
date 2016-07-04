class Admissions::ContestsController < Admissions::AdmissionsController
  load_resource find_by: :id
  authorize_resource

  def index
    @contests = Contest.paginate(page: params[:page], per_page: @per_page)
  end

  def show
    @contest = Contest.find(params[:id])
    @entrants = @contest.referrers.paginate(page: params[:page], per_page: @per_page)
  end

  def new
    @contest = Contest.new
  end

  def create
    @contest = Contest.new(params[:contest])
    if @contest.save
      redirect_to admin_contests_path
    else
      render :new
    end
  end

  def edit
    @contest = Contest.find(params[:id])
  end

  def update
    @contest = Contest.find(params[:id])
    if @contest.update_attributes(params[:contest])
      redirect_to admin_contests_path
    else
      render :edit
    end
  end

  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy
    redirect_to admin_contests_path
  end

  def confirm_destroy
    @contest = Contest.find(params[:id])
  end
end
