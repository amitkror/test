class Admissions::ResourcesController < Admissions::AdmissionsController

  before_filter :set_resource, only: [:edit, :update, :confirm_destroy, :destroy]
  load_resource find_by: :permalink
  authorize_resource

  def index
    respond_to do |format|
      format.html {
        @order = params[:order]
        @status_id = params[:status_id]
        @type_id = params[:type_id]
        @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"

        @resources = Resource.paginate(page: params[:page], per_page: @per_page,
          include: [:last_editor])

        unless @status_id.blank?
          @resources = @resources.where(status_id: @status_id)
        end

        unless @type_id.blank?
          @resources = @resources.where(type_id: @type_id)
        end

        unless @order.blank?
          @resources = @resources.order("#{@order} #{@dir}")
        else
          @resources = @resources.ordered
        end
      }
      format.csv {
        send_data Resource.to_csv(request.host_with_port),
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: "attachment; filename=resources-#{DateTime.now}.csv"
      }
    end
  end

  def show
  end

  def new
    @resource = Resource.new
    @resource.assets.build
  end

  def create
    @resource = Resource.new(params[:resource])
    if @resource.save
      redirect_to admin_resources_path,
        notice: resource_flash(@resource).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @resource.update_attributes(params[:resource])

      @resource.clear_audiences if params[:resource][:audience_ids].blank?
      @resource.clear_boroughs if params[:resource][:borough_ids].blank?
      @resource.clear_languages if params[:resource][:language_ids].blank?
      @resource.clear_phases if params[:resource][:phase_ids].blank?
      @resource.clear_subjects if params[:resource][:subject_ids].blank?
      @resource.clear_subway_lines if params[:resource][:subway_line_ids].blank?
      @resource.clear_supports if params[:resource][:support_ids].blank?

      #raise params[:resource][:assets_attributes].inspect

      redirect_to admin_resources_path,
        notice: resource_flash(@resource).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @resource.destroy
    redirect_to admin_resources_path,
      notice: "Successfully destroyed #{@resource.name}."
  end

  def search
    resources = Resource.super_skinny.where("name ILIKE ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json {
        render json: resources.map{ |resource| {
          name: resource.name,
          id: resource.id,
        }}
      }
    end
  end

  private
    def set_resource
      unless is_numeric?(params[:id])
        @resource = Resource.find_by_permalink!(params[:id])
      else
        @resource = Resource.find_by_id!(params[:id])
        return redirect_to edit_admin_resource_path(@resource)
      end
    end

    def resource_flash(resource)
      render_to_string partial: "flash",
        locals: { resource: resource }
    end

    def is_numeric?(obj)
      (obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil) ? false : true
    end
end
