require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '123456', info: { email: 'new@user.com' }) }

  describe 'POST #twitter' do
    it 'saves new user' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      expect { post :twitter, auth: auth }.to change(User, :count).by(1)
    end
  end
end
