class FoldersController < ApplicationController

	def index
		@folders = Folder.featured.order('created_at DESC').paginate(page: params[:page], per_page: 10)

		# @folders = Folder.paginate(page: params[:page], per_page: @per_page).includes(:user)

	end

	def show

		folder = Folder.find_by_id(params[:id])

		if folder.is_featured?
			@folder = folder
		else
			render :file => "public/404.html", :status => :unauthorized
		end

	end

end
