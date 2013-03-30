module ApplicationHelper

  def rated_users(high_or_low)
    @sorted_users ||= User.all.sort_by { |user| -1 * user.legacy_score }
    if high_or_low == "high"
      @sorted_users[0..9]
    else
      @sorted_users[-10..-1].reverse
    end
  end

  def user_rating
    @sorted_users ||= User.all.sort_by { |user| -1 * user.legacy_score }
    @sorted_users.each_with_index do |user, i|
      if user.username == current_user.username
        return (i+1)
      end
    end
  end
  
  def unread_comments
    Comment.where(:read => false).select! { |c| c.answer.user == current_user && c.user != current_user }
  end
  
  def answer_path_for_comment(comment)
    comment.answer.question
  end

end
