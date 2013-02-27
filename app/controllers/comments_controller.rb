class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    answer = Answer.find(params[:answer_id])
    @comment = answer.comments.build(params[:comment])
    @comment.user_id = current_user.id
    @comment.save!
    if request.xhr?
      render 'questions/comment', :layout => false
    else
      redirect_to root_url
    end
  end

  def destroy
  end
end
