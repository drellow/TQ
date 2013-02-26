require 'spec_helper'

describe "Posting answers" do

  subject { page }

  context "before answers are posted" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:question) { FactoryGirl.create(:question) }
    let!(:answer) { FactoryGirl.create(:answer) }

    before { visit '/' }

    it { should_not have_content(answer.body) }
  end

  context "after posting anwers" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:question) { FactoryGirl.create(:question) }
    let!(:answer) { FactoryGirl.create(:answer) }

    before do
      # Question.todays_question.toggle!(:posted_answers)
      make_admin user
      log_in user
      visit '/'
      click_link("Post Answers")
    end

    it { puts page.html
      should have_content(answer.body) }
  end


end