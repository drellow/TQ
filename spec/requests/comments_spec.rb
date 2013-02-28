require 'spec_helper'

describe "Adding comments" do

  subject { page }

  context "when logged in" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:question) { FactoryGirl.create(:question) }
    let!(:anwer) { FactoryGirl.create(:answer) }

    before do
      log_in user
      post_answers
      visit '/'
    end

    it "should allow user to comment on answers" do
      expect do
        puts page.html
        find('.show-comments').click
        fill_in "comment[body]", with: "My Comment."
        click_button "Add Comment"
      end.to change { user.comments.count }.by(1)
    end
  end

end