class Admissions::TagsController < Admissions::AdmissionsController

  before_filter :set_tag, only: [:destroy]
  load_resource find_by: :permalink
  authorize_resource

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params[:tag])
    respond_to do |format|
      format.js {
        if @tag.save
          render :create
        else
          render js: "alert('Sorry, something went wrong.');"
        end
      }
    end
  end

  def update

  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.js { render :destroy }
    end
  end

  private

  def set_tag
    @tag = Tag.find_by_permalink!(params[:id])
  end

end
