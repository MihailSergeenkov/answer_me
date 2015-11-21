class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :current_question
  before_action :load_answer, only: [:edit, :update, :destroy]

  def index
    @answers = @question.answers.all
  end

  def new
    @answer = @question.answers.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @question
    else
      flash.now[:notice] = 'Please, enter the correct data!'
      render :new
    end
  end

  def update
    if @answer.user_id == current_user.id
      if @answer.update(answer_params)
        redirect_to @question, notice: 'Your answer is saved!'
      else
        render :edit
      end
    else
      redirect_to @question, notice: 'You is not owner of this answer!'
    end
  end

  def destroy
    if @answer.user_id == current_user.id
      @answer.destroy
      redirect_to @question, notice: 'Your answer is deleted!'
    else
      redirect_to @question, notice: 'You is not owner of this answer!'
    end
  end

  private

  def current_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
