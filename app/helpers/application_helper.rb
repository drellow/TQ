module ApplicationHelper

  def rated_users(high_or_low)
    @sorted_users ||= User.all.sort_by { |user| -1 * user.legacy_score }
    if high_or_low == "high"
      @sorted_users[0..9]
    else
      @sorted_users.select! do |user|
        user.answers.count > 0
      end.reverse[-10..-1]
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
  
  def activity_feed
    new_comments = Comment.where(:read => false).select! { |c| c.answer.user == current_user && c.user != current_user }
    if new_comments.count > 0
      {:feed_count => new_comments.count, :items => new_comments}
    else
      {:feed_count => 0, :items => Comment.all.select! { |c| c.answer.user == current_user && c.user != current_user }[0..10]}
    end
  end
end
