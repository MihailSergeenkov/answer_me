require_relative '../acceptance_helper'

feature 'User sign up', %q{
  In order to be able to ask question
  As an user
  I want to be able to sign up
} do

  given(:user) { build(:user) }

  scenario 'User try to sign up' do
    sign_up(user)

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Registered user try to sign up retry' do
    sign_up(user)
    click_on 'Logout'
    sign_up(user)

    expect(page).to have_content 'Email has already been taken'
  end
end
