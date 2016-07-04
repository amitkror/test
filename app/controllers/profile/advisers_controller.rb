class Profile::AdvisersController < Profile::ProfileController

  def index
    @order = params[:order]
    @per_page = params[:per_page] || session[:per_page] || 10
    @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"
    # @questions = current_user.adviser_guest_questions.includes(:user).paginate(
    #   page: params[:page], per_page: @per_page)

    # fail
    questions = (current_user.adviser_questions + current_user.adviser_guest_questions).sort {|x, y| y.created_at <=> x.created_at}

    @questions = WillPaginate::Collection.create(1, @per_page, questions.length) do |pager|
      pager.replace questions
    end

    unless @order.blank?
      @questions = @questions.order("#{@order} #{@dir}")
    else
      # @questions = @questions.sort {|x, y| x.created_at <=> y.created_at}
    end

  end

  def show
    @question = current_user.adviser_questions.find_by_id!(params[:id])
    @question.mark_read current_user
  end

end
