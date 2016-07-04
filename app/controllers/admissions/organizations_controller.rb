class Admissions::OrganizationsController < Admissions::AdmissionsController
  before_filter :set_organization, except: [:index, :new, :create]
  load_resource find_by: :permalink
  authorize_resource

  def index
    @organizations = Organization.ordered.paginate page: params[:page], per_page: @per_page
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      redirect_to admin_organizations_path,
        notice: organization_flash(@organization).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @organization.update_attributes(params[:organization])
      redirect_to admin_organizations_path,
        notice: organization_flash(@organization).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @organization.destroy
    redirect_to admin_organizations_path,
      notice: "Successfully destroyed #{@organization.name}."
  end

  private
    def set_organization
      @organization = Organization.find_by_permalink!(params[:id])
    end

    def organization_flash(organization)
      render_to_string partial: "flash",
        locals: { organization: organization }
    end
end
