module OmniauthMacros
  def facebook_auth_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'user@email.ru' })
  end
end
