class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: 'Thanks! Your question is saved!'
    else
      flash[:notice] = 'Please, enter the correct data!'
      render :new
    end
  end

  def update
    if @question.user_id == current_user.id
      if @question.update(question_params)
        redirect_to @question, notice: 'Your question is saved!'
      else
        render :edit
      end
    else
      redirect_to @question, notice: 'You is not owner of this question!'
    end
  end

  def destroy
    if @question.user_id == current_user.id
      @question.destroy
      redirect_to questions_path, notice: 'Your question is deleted!'
    else
      redirect_to questions_path, notice: 'You is not owner of this question!'
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
