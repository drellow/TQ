# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tq::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => "cdrellow",
  :password => "$endgr1d",
  :domain => "thetq.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}