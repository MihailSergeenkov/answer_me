class OmniauthCallbacksController < Devise::OmniauthCallbacksController
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
      render 'users/require_user_email', locals: { auth: auth }
    end
  end

  def auth
    request.env['omniauth.auth'] || OmniAuth::AuthHash.new(params[:auth])
  end
end
