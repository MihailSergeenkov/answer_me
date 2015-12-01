require_relative '../acceptance_helper'

feature 'User sign out', %q{
  As an user
  I want to be able to sign out
} do

  given(:user) { create(:user) }

  scenario 'Authenticate user try to sign out' do
    sign_in(user)

    click_on 'Logout'

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-authenticate user try to sign out' do
    visit new_user_session_path
    expect(page).to_not have_content 'Logout'
  end
end
