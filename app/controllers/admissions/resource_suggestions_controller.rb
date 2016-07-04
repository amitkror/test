class Admissions::ResourceSuggestionsController < Admissions::AdmissionsController
  before_filter :set_resource_suggestion, only: [:edit, :update,
    :confirm_destroy, :destroy]

  load_resource find_by: :permalink
  authorize_resource

  def index
    respond_to do |format|
      format.html {
        @order = params[:order]
        @type_id = params[:type_id]
        @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"

        @resource_suggestions = ResourceSuggestion.paginate(page: params[:page],
          per_page: @per_page)

        unless @type_id.blank?
          @resource_suggestions = @resource_suggestions.where(type_id: @type_id)
        end

        unless @order.blank?
          @resource_suggestions = @resource_suggestions.order("#{@order} #{@dir}")
        else
          @resource_suggestions = @resource_suggestions.ordered
        end
      }
      format.csv {
        send_data ResourceSuggestion.to_csv(request.host_with_port),
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: "attachment; filename=resource_suggestions-#{DateTime.now}.csv"
      }
    end
  end

  def edit
  end

  def update
    if @resource_suggestion.update_attributes(params[:resource_suggestion])
      redirect_to admin_resource_suggestions_path,
        notice: resource_suggestion_flash(@resource_suggestion).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @resource_suggestion.destroy
    redirect_to admin_resource_suggestions_path,
      notice: "Successfully destroyed #{@resource_suggestion.title}."
  end

  private
    def set_resource_suggestion
      @resource_suggestion = ResourceSuggestion.find_by_id!(params[:id])
    end

    def resource_suggestion_flash(resource_suggestion)
      render_to_string partial: "flash",
        locals: { resource_suggestion: resource_suggestion }
    end
end
