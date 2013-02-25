require 'spec_helper'

describe Answer do
  @user = User.new(:username => "foo", :email => "foo@bar.com",
                   :password => "password", :password_confirmation => "password")
  @answer = Answer.create!(:user_id => 1, :body => "My answer")


end
