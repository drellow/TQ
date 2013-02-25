def log_in(user)
  visit login_path
  fill_in "Username",    with: user.username
  fill_in "Password", with: user.password
  click_button "Log in"

  cookies[:session_token] = user.session_token
end

def make_admin(user)
  user.toggle!(:admin)
end