class Notifier < ActionMailer::Base
  default :from => "\"Wolfff TQ\" <info@thetq.net>"

  def email_answers(user)
    mail( :to => user.email,
      :subject => "Answers posted!" )
  end

  def email_question(user)
    mail( :to => user.email,
      :subject => Question.todays_question.body )
  end
end