class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    answer = Answer.find(params[:answer_id])
    comment = answer.comments.build(params[:comment])
    comment.user_id = current_user.id
    comment.save!
    redirect_to '/'
  end

  def destroy
  end
end
