require_relative '../acceptance_helper'

feature 'User sign up', %q{
  In order to be able to ask question
  As an user
  I want to be able to sign up
} do

  given(:user) { build(:user) }

  before do
    sign_up(user)
    open_email(user.email)
    current_email.click_link 'Confirm my account'
  end

  scenario 'User try to sign up' do
    sign_in(user)
    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Registered user try to sign up retry' do
    sign_up(user)
    expect(page).to have_content 'Email has already been taken'
  end
end
