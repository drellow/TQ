require 'spec_helper'

describe "Answering questions" do

  subject { page }

  context "before logging in" do
    before { visit '/' }
    it { should_not have_button "Answer" }
  end

  context "as a logged-in user" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      log_in user
      visit '/'
    end
      it { should have_button("Answer") }
  end

  context "before a question has been asked" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      log_in user
      visit '/'
    end

    it { should have_content("No question posted") }
    it { should_not have_button("Answer") }
  end

  context "after answering the question" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:question) { FactoryGirl.create(:question) }

    before do
      log_in user
      visit '/'
      fill_in "answer[body]", with: "This is my answer"
      click_button "Answer"
    end

    it { should_not have_button("Answer") }
    it { should have_content("This is my answer") }
  end


end