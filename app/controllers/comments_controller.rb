class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: :create

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    @css_id_commentable = "##{@comment.commentable_type.underscore}-#{@comment.commentable.id}"
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user.author_of?(@comment)
  end

  private

  def set_commentable
    @commentable = commentable_name.classify.constantize.find(params[commentable_id])
  end

  def commentable_name
    params['commentable']
  end

  def commentable_id
    (commentable_name.singularize + '_id').to_sym
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
