class Api::V1::QuestionsController < Api::V1::BaseController
  authorize_resource Question, user: @current_resource_owner

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with(@question = Question.find(params[:id]))
  end

  def create
    respond_with(@question = @current_resource_owner.questions.create(question_params))
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
