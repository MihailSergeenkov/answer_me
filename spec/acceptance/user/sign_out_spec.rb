require 'rails_helper'

feature 'User sign out', %q{
  As an user
  I want to be able to sign out
} do

  scenario 'Authenticate user try to sign out' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    click_on 'Logout'

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticate user try to sign out' do
    visit new_user_session_path
    expect(page).to_not have_content 'Logout'
  end
end
