module Admissions::UsersHelper

  def last_signin(user)
    user.current_sign_in_at.blank? ? "Never" : l(user.current_sign_in_at)
  end

  def resource_data(user)
    data = user.resources.map{ |resource| {
      id: resource.id,
      name: resource.name,
    }}
    return data.to_json
  end
end