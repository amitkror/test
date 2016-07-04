class Admissions::FolderRecommendationsController < Admissions::AdmissionsController

  require 'will_paginate/array'

  before_filter :unfeature_folder, only: [:delete, :destroy]

  load_resource find_by: :id
  authorize_resource

	def index

		respond_to do |format|
      format.html {
        @order = params[:order]
        @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"

        # flash[:notice] = params[:status]

        case params[:folderSubmissionStatus]
        when 'true'
          filter = true
        when 'false'
          filter = false
        else
          filter = nil
        end

        @recommendations = FolderRecommendation.order('folder_recommendations.created_at DESC').recommendation_status(filter).paginate(page: params[:recommendation_page],

          per_page: @per_page)

      }

    end

	end

  def unfeature_folder
    puts '########################################################################'
    # puts params[:id]
    @recommendation = FolderRecommendation.find(params[:id])
    @folder = @recommendation.folder

    @folder.is_featured = false

    @folder.save
  end

	def destroy
		@recommendation = FolderRecommendation.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to admin_folder_recommendations_url }
      format.json { head :no_content }
    end
	end

	def show
		@recommendation = FolderRecommendation.find(params[:id])

		@folder = Folder.find(@recommendation.folder_id)

		@resources = @folder.resources
	end

end
