class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    answer = Answer.find(params[:answer_id])

    @comment = answer.comments.build(params[:comment])
    @comment.user_id = current_user.id
    @comment.save!
    FeedItem.create(:user_id => answer.user_id, :scope => @comment.id, 
                   :path => "/questions/#{answer.question.id}#comment#{@comment.id}",
                   :body => "#{@comment.user.username} commented on your answer.")

    if request.xhr?
      render 'questions/comment', :layout => false
    else
      redirect_to root_url
    end
  end

  def destroy
  end
end
