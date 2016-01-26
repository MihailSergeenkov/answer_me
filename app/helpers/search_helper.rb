module SearchHelper
  def from_comment(comment)
    case comment.commentable_type
    when 'Question'
      comment.commentable.id
    when 'Answer'
      comment.commentable.question.id
    end
  end
end
