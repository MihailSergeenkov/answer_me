class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: :create
  before_action :set_comment, only: :destroy

  respond_to :js

  def create
    respond_with(@comment = @commentable.comments.create(comment_params.merge!(user_id: current_user.id)))
  end

  def destroy
    respond_with(@comment.destroy) if current_user.author_of?(@comment)
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

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
