class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      quest_abilities
    end
  end

  def quest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    quest_abilities
    can :create, [Question, Answer, Comment]
    can :edit, [Question, Answer]
    can :update, [Question, Answer], user: user
    can :destroy, [Question, Answer, Comment], user: user

    alias_action :vote_up, :vote_down, :vote_reset, to: :vote
    can :vote, [Question, Answer]
    cannot :vote, [Question, Answer], user: user

    can :best, Answer, question: { user: user }

    can :manage, Attachment, attachable: { user: user }
  end
end
