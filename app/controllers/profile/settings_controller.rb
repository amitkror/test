class Profile::SettingsController < Profile::ProfileController

  def index
  end

  def update

    unless params[:user][:system_avatar_id].blank?
      system_avatar_id = params[:user][:system_avatar_id].to_i
      current_user.update_attributes(:system_avatar_id => system_avatar_id, :custom_avatar => nil)
    end
      
    params[:user].delete :system_avatar_id  
    if current_user.update_attributes(params[:user])
      #current_user.clear_audiences if params[:user][:user_audience].blank?
      current_user.clear_newsletters if params[:user][:newsletter_ids].blank?
      redirect_to profile_settings_path, notice: "Updated your settings."
    else
      render :index
    end
  end

  def update_avatar
    if current_user.update_attributes(params[:user])
      redirect_to profile_settings_path, notice: "Updated your settings."
    else
      render :index
    end
  end

  def confirm_destroy
    render layout: 'layouts/popup'
  end

  # def audience
  #   audience_id = params[:audience_id]
  #   audience = Audience.find(audience_id)

  #   render json: { success:true, audience_name: audience.name, audience_id: audience_id}
  # end


  def destroy
    current_user.destroy unless current_user.admin?
    flash[:notice] = "Your account has been deleted."
    return render js: "window.parent.location = '#{root_path}';"
  end

end
