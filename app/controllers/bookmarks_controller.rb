class BookmarksController < ApplicationController

  before_filter :authenticate_user!, only: [:create, :update]

  def create
    # This now creates folder a folder and a bkmark but the folder name isn't saved
    folder = Folder.new({ name: params[:folder_name], user: current_user })

    unless folder.save
      return render json: { success: false, message: folder.errors.to_a }
    end

    @bkmrk = Bookmark.new({
      user: current_user,
      folder: folder,
      resource_id: params[:resource_id]
    })
    @bkmrk.save

    if @bkmrk.save
      render json: { success: true, name: folder.name,
        resource: @bkmrk.resource_id, has_bookmark: true }
    else
      render json: { success: false, message: @bkmrk.errors.to_a }
    end
  end

  def sort
    @assign_folder = false

    if current_user.blank?
      return render js: "window.location = '#{new_user_registration_path}'"
    else

      folder_ids = params[:folder_ids] || []
      resource_id = params[:resource_id]

      current_folder_ids = current_user.bookmarks.where(resource_id: resource_id).pluck('folder_id')

      bookmarks_to_delete = current_folder_ids - folder_ids

      bookmarks_to_add = folder_ids - current_folder_ids

      current_user.bookmarks.where(folder_id: bookmarks_to_delete, resource_id: resource_id).each do |bookmark|
        bookmark.destroy
      end

      bookmarks_to_add.each do |folder_id|
        Bookmark.create!({ user_id: current_user.id, folder_id: folder_id,
          resource_id: resource_id })
      end

      render json: { success: true, has_bookmark: folder_ids.size > 0, resource: resource_id }

    end
  end

  def toggle
    if current_user.blank?
      return render js: "window.location = '#{new_user_registration_path}'"
    else

      @bkmrk = Bookmark.new
      @resource_id = params[:resource_id]
      @current_folders = current_user.bookmarks.where(resource_id: @resource_id).pluck('folder_id')

      respond_to do |format|
        format.html {
          redirect_to resource_path(@bkmrk.resource)
        }
        format.js
      end
    end
  end


  def move
    @bkmrk = current_user.bookmarks.where(resource_id: params[:resource_id]).first
  end

  def update
    @bkmrk = Bookmark.find_by_id!(params[:id])
    @bkmrk.folder_id = params[:folder_id]
    if @bkmrk.save
      render json: { success: true }
    else
      render json: { success: false, message: @bkmrk.errors.to_a }
    end
  end

end
