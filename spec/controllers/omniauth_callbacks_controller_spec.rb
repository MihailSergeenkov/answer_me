require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  let(:auth_twitter) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '123456', info: { email: 'new@twitter.com' }) }

  before { @request.env['devise.mapping'] = Devise.mappings[:user] }

  describe 'POST #twitter' do
    it 'saves new user' do
      session['devise.auth'] = { provider: 'twitter', uid: '123456' }
      expect { post :twitter, auth: { info: { email: 'new@twitter.com' } } }.to change(User, :count).by(1)
    end
  end

  describe 'GET #facebook' do
    let(:do_request) { get :facebook }

    before do
      mock_auth_hash(:facebook)
      @request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    end

    it_behaves_like 'Omni Auth User'
  end

  describe 'GET #twitter' do
    context 'User with email' do
      let(:do_request) { get :twitter }

      before do
        mock_auth_hash(:twitter)
        @request.env['omniauth.auth'] = auth_twitter
      end

      it_behaves_like 'Omni Auth User'
    end

    context 'User without email' do
      before do
        mock_auth_hash(:twitter)
        @request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
      end

      it 'User don\'t created' do
        expect { get :twitter }.to_not change(User, :count)
      end

      it 'render email form' do
        get :twitter
        expect(response).to render_template 'users/require_user_email'
      end
    end
  end
end
