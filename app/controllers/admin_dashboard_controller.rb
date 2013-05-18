class AdminDashboardController < ApplicationController
  before_filter :admin_user

  def dashboard
  end

  def answers
  end

  def email_answers
    unless Question.todays_question.emailed_answers
      Notifier.email_answers
      redirect_to admin_dashboard_path
    else
      flash[:alert] = 'You already sent out the answers!'
      redirect_to admin_dashboard_path
    end
  end
end
