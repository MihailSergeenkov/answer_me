require_relative '../acceptance_helper'

feature 'Sign in with Vkontakte'do
  before { visit new_user_session_path }

  describe 'User can sign in with his Vkontakte account' do
    before do
      mock_auth_hash(:vkontakte)
      click_on 'Sign in with Vkontakte'
    end

    scenario 'after conform email' do
      open_email(OmniAuth.config.mock_auth[:vkontakte]['info']['email'])
      current_email.click_link 'Confirm my account'
      expect(page).to have_content 'Your email address has been successfully confirmed.'
      click_on 'Sign in with Vkontakte'

      expect(page).to have_content 'Successfully authenticated from Vkontakte account'
    end

    scenario 'before conform email' do
      visit new_user_session_path
      click_on 'Sign in with Vkontakte'

      expect(page).to have_content 'You have to confirm your email address before continuing.'
    end
  end

  scenario 'authentication error' do
    OmniAuth.config.mock_auth[:vkontakte] = :invalid_credentials
    click_on 'Sign in with Vkontakte'

    expect(page).to have_content 'Could not authenticate you from Vkontakte'
  end
end
