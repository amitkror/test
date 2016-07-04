class Admissions::AssetsController < Admissions::AdmissionsController

  before_filter :set_asset, except: [:index, :new, :create, :browse, :search]
  before_filter :set_pages, only: [:new, :edit]
  before_filter :set_new_asset, only: [:new, :browse]

  load_resource find_by: :permalink
  authorize_resource

  def index
    @assets = Asset.recent.paginate page: params[:page], per_page: @per_page
  end

  def new
  end

  def create
    @asset = Asset.new(params[:asset])
    respond_to do |format|
      format.html {
        if @asset.save
          redirect_to admin_assets_path, notice: asset_flash(@asset).html_safe
        else
          set_pages
          render :new
        end
      }
      format.json {
        @asset.attachment = params[:file]
        if @asset.save
          render json: {
            success: true,
            id: @asset.id,
            file: @asset.attachment.thumb('500x34').url,
            title: @asset.title,
            url: edit_admin_asset_path(@asset),
          }
        else
          render json: { success: false, errors: @asset.errors }
        end
      }
    end
  end

  def edit
  end

  def update
    if @asset.update_attributes(params[:asset])
      redirect_to admin_assets_path, notice: asset_flash(@asset).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @asset.destroy
    redirect_to admin_assets_path,
                notice: "Successfully destroyed #{@asset.title}."
  end

  def browse
    @assets = Asset.recent.images.paginate page: params[:page], per_page: 49
    render layout: 'admissions/layouts/popup'
  end

  def details
    size = params[:size]
    @asset = Asset.find_by_id!(params[:id])
    render json: {
      filename: @asset.attachment.thumb(size).url,
      width: size.split('x').first,
    }
  end

  def search
    @assets = Asset.super_skinny
                   .where("alt ILIKE ? OR title ILIKE ?",
                          "%#{params[:q]}%",
                          "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json {
        render json: @assets.map{ |asset| {
          name: asset.title,
          id: asset.id,
          file: asset.attachment.thumb('500x34').url,
          url: edit_admin_asset_path(asset),
        }}
      }
    end
  end

  private
    def set_asset
      @asset = Asset.find_by_id!(params[:id])
    end

    def set_new_asset
      @asset = Asset.new
    end

    def asset_flash(asset)
      render_to_string partial: "flash", locals: { asset: asset }
    end
end
