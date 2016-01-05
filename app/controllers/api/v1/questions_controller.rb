module Api
  module V1
    class QuestionsController < Api::V1::BaseController
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
  end
end
