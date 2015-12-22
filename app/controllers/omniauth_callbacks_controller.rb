class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    oauth_provider(:facebook)
  end

  def vkontakte
    oauth_provider(:vkontakte)
  end

  private

  def oauth_provider(provider)
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.to_s.humanize) if is_navigational_format?
    end
  end
end
