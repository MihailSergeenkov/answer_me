class User < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes
  has_many :authorizations
  has_many :subscriptions, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :vkontakte, :twitter]

  def author_of?(post)
    id == post.user_id
  end

  def voted?(post)
    votes.find_by(user: self, votable: post)
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    if auth.info.email
      email = auth.info.email
      user = User.where(email: email).first
      if user
        user.create_authorization(auth)
      else
        password = Devise.friendly_token[0, 20]
        user = User.create!(email: email, password: password, password_confirmation: password)
        user.create_authorization(auth)
      end
    else
      user = User.new
    end
    user
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid.to_s)
  end
end
