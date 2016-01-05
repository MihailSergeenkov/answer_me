module Api
  module V1
    class QuestionsController < Api::V1::BaseController
      def index
        @questions = Question.all
        respond_with @questions
      end

      def show
        @question = Question.find(params[:id])
        respond_with @question
      end
    end
  end
end
