class Notifier < ActionMailer::Base
  default :from => "\"Wolfff TQ\" <info@thetq.net>"
  
  def email_answers
    addresses = User.where(:receives_email => true).select(:email).map(&:email)
    mail( :to => addresses, :subject => "Answers Posted!")
    Question.todays_question.update_attributes(:emailed_answers => true)
  end

  def email_question(user)
    mail( :to => user.email,
      :subject => Question.todays_question.body )
  end
end