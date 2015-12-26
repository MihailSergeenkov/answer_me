class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_authorization_check

  def facebook
    oauth_provider(:facebook)
  end

  def vkontakte
    oauth_provider(:vkontakte)
  end

  def twitter
    oauth_provider(:twitter)
  end

  private

  def oauth_provider(provider)
    @user = User.find_for_oauth(auth)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.to_s.humanize) if is_navigational_format?
    else
      flash[:notice] = 'Please, specify your email for sign up'
      session['devise.auth'] = { provider: request.env['omniauth.auth'].provider, uid: request.env['omniauth.auth'].uid }
      render 'users/require_user_email'
    end
  end

  def auth
    request.env['omniauth.auth'] || OmniAuth::AuthHash.new(params[:auth].merge!(session['devise.auth']))
  end
end
