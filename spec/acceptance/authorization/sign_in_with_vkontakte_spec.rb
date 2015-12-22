require_relative '../acceptance_helper'

feature 'Sign in with Vkontakte'do
  before { visit new_user_session_path }

  scenario 'user can sign in with his Vkontakte account' do
    mock_auth_hash(:vkontakte)
    click_on 'Sign in with Vkontakte'

    expect(page).to have_content 'Successfully authenticated from Vkontakte account'
  end

  scenario 'authentication error' do
    OmniAuth.config.mock_auth[:vkontakte] = :invalid_credentials
    click_on 'Sign in with Vkontakte'

    expect(page).to have_content 'Could not authenticate you from Vkontakte'
  end
end
