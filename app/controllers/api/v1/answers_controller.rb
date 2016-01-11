class Api::V1::AnswersController < Api::V1::BaseController
  before_action :current_question, only: [:index, :show, :create]

  authorize_resource Answer, user: @current_resource_owner

  def index
    respond_with(@answers = @question.answers)
  end

  def show
    respond_with(@answer = @question.answers.find(params[:id]))
  end

  def create
    respond_with(@answer = @question.answers.create(answer_params.merge!(user_id: @current_resource_owner.id)))
  end

  private

  def current_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
