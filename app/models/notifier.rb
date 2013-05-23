class Notifier < ActionMailer::Base
  default :from => "\"Wolfff TQ\" <info@thetq.net>"

  # send a signup email to the user, pass in the user object that contains the user's email address
  # def signup_email(user)
  #   mail( :to => user.email,
  #   :subject => "Thanks for signing up" )
  # end
  
  def email_answers
    User.where(:receives_email => true).each do |user|
      email_answer(user).deliver
    end
    Question.todays_question.update_attributes(:emailed_answers => true)
  end

  def email_question(user)
    mail( :to => user.email,
      :subject => Question.todays_question.body )
  end

  def email_answer(user)
    mail( :to => user.email,
      :subject => "Answers posted!" )
  end
end