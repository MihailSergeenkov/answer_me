class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  include Voted

  def index
    @questions = Question.order(:created_at)
  end

  def show
    @answer = @question.answers.new
    @answer.attachments.new
  end

  def new
    @question = Question.new
    @question.attachments.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: 'Thanks! Your question is saved!'
      PrivatePub.publish_to "/questions", question: [@question.id, @question.title, @question.body.truncate(20)]
    else
      flash[:notice] = 'Please, enter the correct data!'
      render :new
    end
  end

  def update
    if current_user.author_of?(@question)
      @question.update(question_params)
    else
      redirect_to @question, notice: 'You is not owner of this question!'
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      flash[:notice] = 'Your question is deleted!'
    else
      flash[:notice] = 'You is not owner of this question!'
    end

    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
