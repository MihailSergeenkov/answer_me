module QuestionsHelper
  def subscribed?(post)
    post.question_subscribtion(current_user)
  end
end
