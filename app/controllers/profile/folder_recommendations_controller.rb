class Profile::FolderRecommendationsController < Profile::FoldersController

	def create
		# flash p
		@recommendation = FolderRecommendation.new(params[:folder_recommendation])
		
		if @recommendation.save
			@template = 'profile/folder_recommendations/success'
		end

	end

	def new

		@folder_options = Folder.belongs_to_user(current_user.id)

		@selected = params[:folderID] || @folder_options.first

	end

end
