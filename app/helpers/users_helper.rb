module UsersHelper

  def users_current_answer
      current_user.answers.where('created_at BETWEEN ? AND ?',
      DateTime.now.beginning_of_day, DateTime.now.end_of_day).first
    end
end
