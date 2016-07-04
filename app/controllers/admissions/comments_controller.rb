class Admissions::CommentsController < Admissions::AdmissionsController
  before_filter :set_comment, only: [:edit, :update,
    :confirm_destroy, :destroy]

  load_resource find_by: :permalink
  authorize_resource

  def index
    respond_to do |format|
      format.html {
        @order = params[:order]
        @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"

        @comments = Comment.paginate(page: params[:page],
          per_page: @per_page).includes(:user)

        unless @order.blank?
          @comments = @comments.order("#{@order} #{@dir}")
        else
          @comments = @comments.ordered
        end
      }
      format.csv {
        send_data Comment.to_csv,
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: "attachment; filename=comments-#{DateTime.now}.csv"
      }
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(params[:comment])
      redirect_to admin_comments_path,
        notice: comment_flash(@comment).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @comment.destroy
    redirect_to admin_comments_path,
      notice: "Successfully destroyed the comment."
  end

  private
    def set_comment
      @comment = Comment.find_by_id!(params[:id])
    end

    def comment_flash(comment)
      render_to_string partial: "flash",
        locals: { comment: comment }
    end
end
