module UsersHelper
  include Rack::Recaptcha::Helpers

  # TODO cache these
  def user_avatar(user, size="150x150#")

    return "" if user.avatar.blank?

    image_tag(user.avatar.thumb(size).url,
      class: 'avatar',
      alt: user.username
    ).html_safe
  end

  def user_avatar_small(user)
    user_avatar(user, '75x75#')
  end

  def user_username(user)
    return user.username unless user.verified?
    "#{user.username} <i class='icon verified tip' title='#{user.verified_type_s}' data-tip-class='verified'></i>".html_safe
  end

  def user_profile_status(user)
    if !user.verified?
      if user.custom_avatar.present? && !user.user_audiences.any?
        return "45"
      elsif !user.custom_avatar.present? && user.user_audiences.any?
         return "60"  
      elsif user.custom_avatar.present? && user.user_audiences.any?
        return "80"
      else
        return "25"
      end
    elsif user.verified?
      if user.custom_avatar.present? && !user.user_audiences.any?
        return "70"
      elsif !user.custom_avatar.present? && user.user_audiences.any?
        return "60"  
      elsif  user.custom_avatar.present? && user.user_audiences.any?
        return "100"
      else
        return "40"
      end
    end
  end

end
