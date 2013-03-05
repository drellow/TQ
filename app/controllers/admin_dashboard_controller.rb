class AdminDashboardController < ApplicationController
  before_filter :admin_user

  def dashboard
  end

  def answers
  end

  def email_answers
    unless Question.todays_question.emailed_answers
      User.all.each do |user|
        Notifier.email_answers(user).deliver if user.receives_email
      end
      Question.todays_question.update_attributes(:emailed_answers => true)
      redirect_to admin_dashboard_path
    else
      flash[:alert] = 'You already sent out the answers!'
      redirect_to admin_dashboard_path
    end
  end
end
