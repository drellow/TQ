require 'spec_helper'

describe 'profile page' do

  subject { page }

  context 'without password' do
    let!(:user) { FactoryGirl.create(:user)}

    before do
      visit edit_user_registration_path
      fill_in "Email", with: "aeraerae@fooear.com"
      fill_in "user_username", with: "eraera"
      fill_in "Title", with: "The Happy Boy"
      click_button "Update"
    end

    it { 
      puts page.html
      should have_content("Hi, eraera") }
  end

end
