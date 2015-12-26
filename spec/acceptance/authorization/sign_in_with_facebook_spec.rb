require_relative '../acceptance_helper'

feature 'Sign in with facebook'do
  before { visit new_user_session_path }

  describe 'User can sign in with his Facebook account' do
    before do
      mock_auth_hash(:facebook)
      click_on 'Sign in with Facebook'
    end

    scenario 'after conform email' do
      open_email(OmniAuth.config.mock_auth[:facebook]['info']['email'])
      current_email.click_link 'Confirm my account'
      expect(page).to have_content 'Your email address has been successfully confirmed.'
      click_on 'Sign in with Facebook'

      expect(page).to have_content 'Successfully authenticated from Facebook account'
    end

    scenario 'before conform email' do
      visit new_user_session_path
      click_on 'Sign in with Facebook'

      expect(page).to have_content 'You have to confirm your email address before continuing.'
    end
  end

  scenario 'authentication error' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    click_on 'Sign in with Facebook'

    expect(page).to have_content 'Could not authenticate you from Facebook'
  end
end
