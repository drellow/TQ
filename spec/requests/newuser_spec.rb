require 'spec_helper'

describe "Creating new users" do

  before { visit new_user_path }

  it "should create a new user when fields correctly filled" do
    expect do
      fill_in "Username", with: "Frank"
      fill_in "Email", with: "Frank@foobar.com"
      fill_in "Password", with: "foobar"
      fill_in "Password confirmation", with: "foobar"
      click_button "Sign up"
    end.to change {User.all.count}.by(1)
  end

  it "should not create a new user with mismatched passwords" do
    expect do
      fill_in "Username", with: "Frank"
      fill_in "Email", with: "Frank@foobar.com"
      fill_in "Password", with: "foobart"
      fill_in "Password confirmation", with: "foobar"
      click_button "Sign up"
    end.not_to change {User.all.count}
  end

end