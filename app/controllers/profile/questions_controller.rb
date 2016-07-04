class Profile::QuestionsController < Profile::ProfileController

  def index
    @questions = current_user.questions
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params[:question])
    @question.user = current_user
    if @question.save

      QuestionMailer.delay(queue: 'questions').send_to_admins(@question)

      redirect_to success_profile_questions_path
    else
      render :new
    end
  end

  def show
    @question = current_user.questions.find_by_id!(params[:id])
    @question.mark_read current_user
  end

end
