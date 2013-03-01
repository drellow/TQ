module ApplicationHelper

  def sorted_answers
    if current_user.provider == "facebook"
      Question.todays_answers.sort_by do |a|
        current_user.friends_with?(a.user) ? 0 : 1
      end
    else
      Question.todays_answers
    end
  end

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

end
