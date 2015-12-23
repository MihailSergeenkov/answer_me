module OmniauthMacros
  def mock_auth_hash(auth_provider)
    email = auth_provider == :twitter ? nil : "user@#{auth_provider.to_s}.ru"
    OmniAuth.config.mock_auth[auth_provider] = OmniAuth::AuthHash.new(provider: auth_provider.to_s, uid: '123456', info: { email: email })
  end
end
