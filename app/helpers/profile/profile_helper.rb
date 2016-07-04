module Profile::ProfileHelper
  def profile_root_on
    path = request.fullpath
    if path.starts_with?(profile_folders_path) || path == profile_root_path
      return "on"
    end
    path == profile_root_path
  end

  def current_user_user_audiences
    user_audiences = []
    uas = current_user.user_audiences
    audiences = Audience.settings

    audiences.each do |audience|
      # Grab the user_audience by audience Id if a user has that audience already.
      user_audience = uas.select do |ua|
        ua.audience_id == audience.id
      end.first
      user_audience = user_audience.blank? ? UserAudience.new({ audience: audience }) : user_audience
      user_audiences << user_audience
    end
    user_audiences
  end
end
