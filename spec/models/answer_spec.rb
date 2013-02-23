require 'spec_helper'

describe Answer do
  @user = User.new(:username => "foo", :email => "foo@bar.com",
                   :password => "password", :password_confirmation => "password")
  @answer = Answer.create!(:user_id => 1, :body => "My answer")

  it "has a cumulative score based on votes" do
    vote = @user.votes.build(:answer_id => 1, :score => 1)
  end
end
