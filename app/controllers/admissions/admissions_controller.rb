class Admissions::AdmissionsController < ApplicationController

  before_filter :authenticate_user!, :authorize, :set_current_user
  # load_resource find_by: :permalink
  # authorize_resource
  before_filter :per_page, only: [:index]
  layout 'admissions/layouts/application'

  def index
  end

  protected
    def authorize
      redirect_to root unless current_user.admin? || current_user.intern? || current_user.blogger?
      # authorize! :manage, :all
      # authorize! :read, :all if current_user.intern?
    end

    def per_page
      @per_page = params[:per_page] || session[:per_page] || 25
      session[:per_page] = @per_page
    end

    def ancestry_options(items)
      result = []
      items.map do |item, sub_items|
        result << [yield(item), item.id]
        #this is a recursive call:
        result += ancestry_options(sub_items) {|i|
          "#{'-' * i.depth} #{i.short_title}"
        }
      end
      result
    end

    def set_pages
      @pages = ancestry_options(
        Page.scoped.arrange(order: 'pages.order, pages.title')) {
          |i| "#{'-' * i.depth} #{i.short_title}"
        }
    end
end
