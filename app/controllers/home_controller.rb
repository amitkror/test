class HomeController < ApplicationController
include Rack::Recaptcha::Helpers

  #layout 'layouts/no_search'
  layout 'layouts/new_design'

  def index

    site_setting = SiteSetting.first
    @slides = []
    @promos = []
    @quicklinks = []
    unless site_setting.blank?
      @slides = site_setting.home_slides
      @promos = site_setting.promo_connections.includes(:promo_instance)
      @quicklinks = site_setting.quick_links.order("quick_links.order ASC")
    end
    
    if current_user
      redirect_to profile_root_path
    end

    @guest_email = session[:guest_email]
    @guest_zipcode = session[:guest_zipcode]
    @guest_question = GuestQuestion.new

    if session[:guest_user_id]
      guest_user = GuestUser.find(session[:guest_user_id])
      guest_params = guest_user.attributes.slice('email', 'zipcode')
      @user = User.new(guest_params)
    else
      @user = User.new
    end

    @contest_copy = false
    if params[:ref]
      @contest_copy = true
      cookies.signed[:advisorref] = { value: params[:ref], expires: 24.hours.from_now }
    end
  end
end