class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    answer = Answer.find(params[:answer_id])

    @comment = answer.comments.build(params[:comment])
    @comment.user_id = current_user.id
    @comment.save!
    
    commenters = []
    answer.comments.each do |c|
      commenters << c.user
    end
    
    current_user.maybe_generate_feed_item
    
    commenters.uniq.each do |commenter|
      next if commenter == current_user || commenter == answer.user
      FeedItem.create(:user_id => commenter.id, :scope => answer.id, 
                      :path => "/questions/#{answer.question.id}#comment#{@comment.id}",
                      :body => "#{@comment.user.username} said a thing about a thing you said a thing about.")
    end
    
    unless answer.user == current_user
      FeedItem.create(:user_id => answer.user_id, :scope => answer.id, 
                      :path => "/questions/#{answer.question.id}#comment#{@comment.id}",
                      :body => "#{@comment.user.username} commented on your answer.")
    end
    if request.xhr?
      render 'questions/comment', :layout => false
    else
      redirect_to root_url
    end
  end

  def destroy
  end
end
