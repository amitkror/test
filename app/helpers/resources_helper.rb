module ResourcesHelper

  def helped(resource)
    cookies[resource.helpful_key] == "1"
  end

end
