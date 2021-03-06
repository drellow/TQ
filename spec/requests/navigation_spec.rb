require 'spec_helper'

describe "Basic page components" do

    subject { page }

    describe "when logged out" do
      before { visit '/' }

      it { should have_link("Log in") }
      it { should have_link("Sign up") }
      it { should_not have_link("Log out") }
    end

    describe "when logged in" do
      let!(:user) { FactoryGirl.create(:user) }

      before do
        log_in(user)
        visit root_path
      end

      it { should have_link("Log out") }
      it { should_not have_link("Log in") }
      it { should_not have_link("Create Question") }
      it { should_not have_link("Post Answers") }
    end

    describe "when admin" do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:question) { FactoryGirl.create(:question) }

      before do
        make_admin(user)
        log_in user
        visit admin_dashboard_path
      end

      it { should have_link("Update Question") }
      it { should have_link("Post Answers") }
    end

end