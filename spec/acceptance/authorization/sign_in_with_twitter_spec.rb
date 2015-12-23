require_relative '../acceptance_helper'

feature 'Sign in with Twitter'do
  before { visit new_user_session_path }

  scenario 'user can sign in with his Twitter account' do
    mock_auth_hash(:twitter)
    click_on 'Sign in with Twitter'

    fill_in 'auth_info_email', with: 'user@twitter.ru'
    click_on 'Submit'

    expect(page).to have_content 'Successfully authenticated from Twitter account'
  end

  scenario 'authentication error' do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    click_on 'Sign in with Twitter'

    expect(page).to have_content 'Could not authenticate you from Twitter'
  end
end
