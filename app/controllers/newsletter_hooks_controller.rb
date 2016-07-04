class NewsletterHooksController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index

    if params[:token] != 'gfvlJkkh4r020wOLEHXWmg'
      return render(nothing: true, status: 500)
    end

    return render(nothing: true) if params[:type].blank?

    type = params[:type]
    email = params[:data][:merges][:EMAIL]
    list_id = params[:data][:list_id]

    user = User.find_by_email!(email)
    newsletter = Newsletter.find_by_mc_list_id!(list_id)

    un = UserNewsletter.where(user_id: user, newsletter_id: newsletter).first

    if type == "subscribe" && un.blank?
      UserNewsletter.create(user_id: user, newsletter_id: newsletter)
    end

    if type == "unsubscribe" && !un.blank?
      un.destroy
    end

    render nothing: true
  end

end