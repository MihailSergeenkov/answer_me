class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :current_question, only: [:new, :create]
  before_action :load_answer, only: [:edit, :update, :destroy, :best]

  def new
    @answer = @question.answers.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    flash[:notice] = 'Please, enter the correct data!' unless @answer.save
  end

  def update
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
    else
      redirect_to @answer.question, notice: 'You is not owner of this answer!'
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
    end
  end

  def best
    if current_user.author_of?(@answer.question)
      @answer.make_best
      @question = @answer.question
    end
  end

  private

  def current_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
