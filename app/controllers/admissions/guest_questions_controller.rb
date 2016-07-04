class Admissions::GuestQuestionsController < Admissions::AdmissionsController
  before_filter :set_question, only: [:edit, :update, :confirm_destroy, :destroy]
  load_resource find_by: :id
  authorize_resource

  def index
    respond_to do |format|
      format.html {
        @order = params[:order]
        @assigned = params[:assigned]
        @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"
        @questions = GuestQuestion.paginate(page: params[:page], per_page: @per_page,
                                       include: [:topic, :adviser, :guest_user])

        unless @assigned.blank?
          if @assigned == "1"
            @questions = @questions.where("adviser_id IS NOT NULL")
          elsif @assigned == "0"
            @questions = @questions.where(adviser_id: nil)
          end
        end

        unless @order.blank?
          @questions = @questions.order("#{@order} #{@dir}")
        else
          @questions = @questions.ordered
        end
      }
      format.csv {
        send_data Question.to_csv(request.host_with_port),
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: "attachment; filename=questions-#{DateTime.now}.csv"
      }
    end
  end

  def edit
  end

  def update
    if @question.update_attributes(params[:question])
      redirect_to admin_guest_questions_path,
                  notice: question_flash(@question).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @question.destroy
    redirect_to admin_guest_questions_path,
                notice: "Successfully destroyed #{@question.question}."
  end

  private
  def set_question
    @question = GuestQuestion.find_by_id!(params[:id])
  end

  def question_flash(question)
    render_to_string partial: "flash",
                     locals: { question: question }
  end
end
