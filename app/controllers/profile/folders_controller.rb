class Profile::FoldersController < Profile::ProfileController

  before_filter :set_folder, only: [:show, :update, :destroy]

  before_filter :ready_recommendation, only: [:show, :index]

  def index
    if params[:act] == 'pwd'      
      @alert_msg = ''
      @alert_msg = 'notice'
    end
    @folders = current_user.folders.ordered
    @folder = Folder.new
    @show_message = false

    unless current_user.set_up_profile
      @show_message = true
      current_user.set_up_profile = true
      current_user.save
    end

  end

  def show
    @bookmarks = @folder.bookmarks.includes(:resource).ordered

  end

  def ready_recommendation
    @folder_options = Folder.belongs_to_user(current_user.id)
  end

  def create
    @folder = Folder.new(params[:folder])
    current_user.folders << @folder
    unless @folder.save
      render js: "alert('Name cannot be blank or longer than 100 chars.');"
    end
  end

  def clone
    # 
    # Get the folder to clone
    # 
    @old_folder = Folder.find_by_id(params[:id])
    # 
    # Duplicate it
    # 
    @folder = @old_folder.dup
    # 
    # reset stuff
    @folder.is_featured = false
    @folder.description = nil
    @folder.slug = nil
    @folder.user_id = current_user.id
    if @folder.save
      # 
      # Get all the bookmarks for the old folder
      bookmarks = @old_folder.bookmarks
      if bookmarks.any?
        bookmarks.each do |b|
          a = b.dup
          a.user_id = current_user.id
          a.folder_id = @folder.id
          a.save
        end
      end

      redirect_to profile_folder_path(@folder)

      flash[:notice] = "You've successfully cloned this folder!"

    else
      render js: "alert('Sorry, something went wrong.');"
    end
    # @old_folder.destroy
  end

  def update
    unless @folder.update_attributes(params[:folder])
      render js: "alert('Name cannot be blank or longer than 100 chars.');"
    end
  end

  def destroy
    if current_user.folders.length > 1
      @folder.destroy
    else
      render js: "alert('You need at least one folder');"
    end
  end

  private
    def set_folder
      @folder = current_user.folders.find_by_id!(params[:id])
    end

end
