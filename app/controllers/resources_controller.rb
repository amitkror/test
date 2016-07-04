class ResourcesController < ApplicationController

  def show
    if user_signed_in? && current_user.verified?
      @resource = Resource.find_by_permalink!(params[:id])
      unless (@resource.active? || @resource.hidden?)
        flash.now[:notice] = ("This resource is not published yet. " +
                  "You can view this because you are logged in staff.")
      end
    else
      @resource = Resource.active_or_hidden.find_by_permalink!(params[:id])
    end
    @other_resources = @resource.organization_rando_resources(@resource)
  end

  def helpful
    resource = Resource.find_by_permalink!(params[:id],
                  select: "id, name, helpful_count")

    key = resource.helpful_key
    @helped = cookies[key].blank? || cookies[key] == "0"

    @count = resource.helpful_count

    if @helped
      cookies[key] = { value: "1", expires: 1.year.from_now }
      @count = @count + 1
    else
      cookies[key] = { value: "0", expires: 1.year.from_now }
      @count = [1, @count - 1].max
    end

    Resource.where(id: resource.id).update_all(helpful_count: @count)
  end

end
