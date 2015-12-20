class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :current_question, only: [:new, :create]
  before_action :load_answer, only: [:edit, :update, :destroy, :best]

  include Voted

  respond_to :html, :js

  def new
    respond_with(@answer = @question.answers.new)
  end

  def edit
  end

  def create
    respond_with(@answer = @question.answers.create(answer_params.merge!(user_id: current_user.id)))
  end

  def update
    return redirect_to(@answer.question, notice: 'You is not owner of this answer!') unless current_user.author_of?(@answer)
    @answer.update(answer_params)
    respond_with @answer
  end

  def destroy
    respond_with(@answer.destroy) if current_user.author_of?(@answer)
  end

  def best
    return unless current_user.author_of?(@answer.question)
    respond_with(@answer.make_best)
  end

  private

  def current_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end
end
