require_relative '../acceptance_helper'

feature 'Sign in with facebook'do
  before { visit new_user_session_path }

  scenario 'user can sign in with his facebook account' do
    mock_auth_hash(:facebook)
    click_on 'Sign in with Facebook'

    expect(page).to have_content 'Successfully authenticated from Facebook account'
  end

  scenario 'authentication error' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    click_on 'Sign in with Facebook'

    expect(page).to have_content 'Could not authenticate you from Facebook'
  end
end
