require_relative '../acceptance_helper'

feature 'Sign in with Twitter'do
  before { visit new_user_session_path }

  describe 'User can sign in with his Twitter account' do
    before do
      mock_auth_hash(:twitter)
      click_on 'Sign in with Twitter'

      fill_in 'auth_info_email', with: 'user@twitter.ru'
      click_on 'Submit'
    end
    
    scenario 'after conform email' do
      open_email('user@twitter.ru')
      current_email.click_link 'Confirm my account'
      expect(page).to have_content 'Your email address has been successfully confirmed.'
      click_on 'Sign in with Twitter'
      expect(page).to have_content 'Successfully authenticated from Twitter account'
    end

    scenario 'before conform email' do
      visit new_user_session_path
      click_on 'Sign in with Twitter'

      expect(page).to have_content 'You have to confirm your email address before continuing.'
    end
  end

  scenario 'authentication error' do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    click_on 'Sign in with Twitter'

    expect(page).to have_content 'Could not authenticate you from Twitter'
  end
end
