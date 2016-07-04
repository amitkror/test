class ApplicationController < ActionController::Base
  protect_from_forgery

  # 404
  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from AbstractController::ActionNotFound, with: :render_404

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.html { redirect_to root_url, alert: exception.message }
        format.all { render text: "403 Forbidden: #{exception.message}" }
      end
    end
  end
  
  def after_sign_in_path_for(resource)
    logger.info "\n\n\n session? #{session[:user_return_to]}\n\n\n"
    if session[:user_return_to].to_s.include? 'users/forgot/new'      
      return profile_root_path
    end
    return profile_root_path if session[:user_return_to].blank?
    session[:user_return_to].to_s
  end

  def set_current_user
    User.current = current_user
  end

  def show
    @page = Page.find_by_absolute_url!("/#{params[:id]}")

    if @page.unpublished?
      unless user_signed_in?
        return render_404
      else
        flash.now[:notice] = "This page is only visible to logged in users."
      end
    end

    unless @page.redirect.blank?
      return redirect_to @page.redirect, status: :moved_permanently
    end

    if @page.phase?
      @promos = @page.promos.includes(:promo_instance)
      return render 'pages/phase'
    end

    unless @page.one_column?
      @promos = @page.promos.includes(:promo_instance)
      render 'pages/show'
    else
      render 'pages/show', layout: 'layouts/one_column'
    end
  end

  private
    def render_404
      error_message = "404 - No route matches \"#{request.env["PATH_INFO"]}\"" +
                      " with {host: \"#{request.env["HTTP_HOST"]}\"," +
                      " method: :#{request.request_method}}"
      logger.error "\n" + error_message + "\n\n"
      respond_to do |format|
        format.html { render 'shared/404', status: :not_found }
        format.all { render text: '404: Not Found', status: :not_found }
      end
    end
end
