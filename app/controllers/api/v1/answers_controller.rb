module Api
  module V1
    class AnswersController < Api::V1::BaseController
      before_action :current_question, only: [:index, :show]

      def index
        @answers = @question.answers
        respond_with @answers
      end

      def show
        @answer = @question.answers.find(params[:id])
        respond_with @answer
      end

      private

      def current_question
        @question = Question.find(params[:question_id])
      end
    end
  end
end
