require 'spec_helper'

describe User do

  before do
    @user = User.new(:username => "foo", :email => "foo@bar.com",
                     :password => "password", :password_confirmation => "password")
    @user2 = User.new(:username => "bar", :email => "bar@bar.com",
                      :password => "password", :password_confirmation => "password")
    @user.save!
    @user2.save!
    Answer.destroy_all
  end

  subject { @user }

  it "can have fans" do
    @user.fans << @user2

    @user.fans.count.should == 1
  end

  it "should require a password" do
    @user = User.new(:username => "food", :email => "food@bar.com")
    @user.should_not be_valid
  end

  it "should not allow for multiple users with the same email" do
    @user3 = User.new(:username => "foo", :email => "foo@bar.com",
                     :password => "password", :password_confirmation => "password")
    @user3.should_not be_valid
  end

  it "should be able to create answers" do
    q = @user.answers.build(:body => "body!", :question_id => 1)
    q.save!
    @user.answers.count.should == 1
  end


end
