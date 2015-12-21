require_relative '../acceptance_helper'

feature 'Sign in with facebook'do
  before { visit new_user_session_path }

  scenario 'user can sign in with his facebook account' do
    expect(page).to have_link 'Sign in with Facebook'
    facebook_auth_hash
    click_on 'Sign in'

    expect(page).to have_content 'Successfully authenticated from Facebook account'
  end

  scenario 'authentication error' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    expect(page).to have_link 'Sign in with Facebook'
    click_on 'Sign in'

    expect(page).to have_content 'Could not authenticate you from Facebook'
  end
end
