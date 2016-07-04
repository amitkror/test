module Admissions::ResourcesHelper

  def user_data(resource)
    data = resource.users.map{ |user| {
      id: user.id,
      name: user.username,
    }}
    return data.to_json
  end
end
