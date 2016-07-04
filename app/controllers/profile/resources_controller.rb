class Profile::ResourcesController < Profile::ProfileController

  before_filter :set_resource, only: [:edit, :update]
  before_filter :set_current_user, only: [:create, :update]

  def index
    @resources = current_user.resources.recent
  end

  def new
    @resource = Resource.new
    authorize! :new, @resource

    @resource.assets.build
    @resource.new_organization = Organization.new
  end

  def create
    @resource = Resource.new(params[:resource])
    authorize! :create, @resource
    @resource.status_id = Resource::STATUSES[:Suggested]
    @resource.users << current_user
    if @resource.save
      redirect_to profile_resources_path,
        notice: "Thank you for submitting a new resource. " +
          "We'll review and approve all additions before they get published"
    else
      render :new
      @resource.new_organization = Organization.new
    end
  end

  def edit
    authorize! :edit, @resource
    @resource.new_organization = Organization.new
  end

  def update
    authorize! :update, @resource
    if @resource.update_attributes(params[:resource])
      @resource.clear_audiences if params[:resource][:audience_ids].blank?
      @resource.clear_boroughs if params[:resource][:borough_ids].blank?
      @resource.clear_languages if params[:resource][:language_ids].blank?
      @resource.clear_phases if params[:resource][:phase_ids].blank?
      @resource.clear_subjects if params[:resource][:subject_ids].blank?
      @resource.clear_subway_lines if params[:resource][:subway_line_ids].blank?
      @resource.clear_supports if params[:resource][:support_ids].blank?

      redirect_to profile_resources_path,
        notice: ("Your edits have been saved. View them here " +
                 "<a href='#{resource_path(@resource)}'>#{@resource.name}</a>").html_safe
    else
      render :edit
      @resource.new_organization = Organization.new
    end
  end

  private
    def set_resource
      @resource = current_user.resources.find_by_permalink!(params[:id])
    end
end
