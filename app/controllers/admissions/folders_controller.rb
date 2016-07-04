class Admissions::FoldersController < Admissions::AdmissionsController
  before_filter :set_folder, only: [:edit, :update]

  load_resource find_by: :permalink
  authorize_resource

  def index
    respond_to do |format|
      format.html {
        @order = params[:order]
        @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"

        @role_id = params[:role_id]

        @folders = Folder.paginate(page: params[:page],
          per_page: @per_page).includes(:user)

        unless @order.blank?
          @folders = @folders.order("#{@order} #{@dir}")
        else
          @folders = @folders.ordered
        end

        unless @role_id.blank?
          @folders = @folders.joins(:user).where("users.role_id = ? ", @role_id).paginate(page: params[:page], per_page: @per_page)
        end
      }
      format.csv {
        send_data Folder.to_csv,
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: "attachment; filename=folders-#{DateTime.now}.csv"
      }
    end
  end

  def edit
  end

  def confirm_destroy
  end

  def generate_slug_from_name name=''
    value = name.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    value.gsub!(/[']+/, '')
    value.gsub!(/\W+/, ' ')
    value.strip!
    value.downcase!
    value.gsub!(' ', '-')
    value
  end

  def update

    # generate a slug from the title
    # if one hasn't been set.

    # logger.warn params.inspect

    f = params[:folder]


    if f['is_featured'] == '1'
      if f['slug'].blank?
        # if no slug, generate from title.
        f['slug'] = generate_slug_from_name Folder.find(@folder.id).name
      else
        # This 'validates' - or rather slugifies, the slug.
        f['slug'] = generate_slug_from_name f['slug']
      end
    end

    if @folder.update_attributes(f)
      if params[:edit_location] == 'recommendation'
        redirect_to admin_folder_recommendations_url
      end
      # if !params[:recommendation_id].blank?
      #   FolderRecommendation.destroy(params[:recommendation_id])
      # end
    end

  end

  private
    def set_folder
      @folder = Folder.find_by_id!(params[:id])
    end
end
