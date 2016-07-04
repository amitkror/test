class OrganizationsController < ApplicationController
  def show
    @page = Page.find_by_absolute_url!("/organizations", select: "id, title")
    @organization = Organization.find_by_permalink!(params[:id])
  end
end
