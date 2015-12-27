class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :new_answer, only: :show
  after_action :publish_question, only: :create

  include Voted

  respond_to :html, :js

  authorize_resource

  def index
    respond_with(@questions = Question.order(:created_at))
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit
  end

  def create
    respond_with(@question = current_user.questions.create(question_params))
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    respond_with(@question.destroy)
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end

  def new_answer
    @answer = @question.answers.new
  end

  def publish_question
    PrivatePub.publish_to "/questions", question: { id: @question.id, title: @question.title, body: @question.body.truncate(20) }.to_json if @question.valid?
  end
end
