def log_in(user)
  visit root_path
  click_link "Log in"
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def make_admin(user)
  user.toggle!(:admin)
end

def post_answers
  Question.todays_question.toggle!(:posted_answers)
end