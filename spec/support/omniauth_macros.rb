module OmniauthMacros
  def mock_auth_hash(auth_provider)
    OmniAuth.config.mock_auth[auth_provider] = OmniAuth::AuthHash.new(provider: auth_provider.to_s, uid: '123456', info: { email: "user@#{auth_provider.to_s}.ru" })
  end
end
