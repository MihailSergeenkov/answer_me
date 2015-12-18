module CommentsHelper
  def css_id_commentable
    "##{@comment.commentable_type.underscore}-#{@comment.commentable.id}"
  end

  def question_id
    case @comment.commentable_type
    when 'Question'
      @comment.commentable.id
    when 'Answer'
      @comment.commentable.question.id
    end
  end
end
