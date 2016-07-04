module ResponsiveHelper

  def profile_urls
    r = [
      ["My folders", profile_root_path],
      ["Settings", profile_settings_path],
      ["Suggest a resource", new_profile_resource_suggestion_path],
    ]
    if current_user.verified?
      r << ["My Questions", profile_advisers_path]
      r << ["My Resources", profile_resources_path]
    else
      r << ["Ask an adviser", new_profile_question_path]
    end

    if Contest.all.count > 0
      r << ["Raffle Contest", profile_contests_path]
    end
    
    r << ["My Forums", profile_forum_threads_path]
    r
  end

end
