class Profile::ResourceSuggestionsController < Profile::ProfileController

  def new
    @resource_suggestion = ResourceSuggestion.new
  end

  def create
    @resource_suggestion = ResourceSuggestion.new(params[:resource_suggestion])
    @resource_suggestion.user = current_user

    if @resource_suggestion.save
      redirect_to new_profile_resource_suggestion_path,
        notice: "Thank you for your suggestion"
    else
      render :new
    end
  end

end
