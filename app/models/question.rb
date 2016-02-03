class Question < ActiveRecord::Base
  include Attachable
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, :body, :user_id, presence: true
  validates :title, length: { maximum: 100 }
  has_many :subscriptions, dependent: :destroy

  scope :created_yesterday, -> { where(created_at: Date.yesterday) }

  default_scope { order(:id) }

  after_create :subscribe_after_create

  def subscribe(user)
    Subscription.create(question: self, user: user) unless subscribed?(user)
  end

  def unsubscribe(user)
    question_subscribtion(user).destroy if subscribed?(user)
  end

  def subscribed?(user)
    Subscription.find_by(question: self, user: user) ? true : false
  end

  private

  def question_subscribtion(user)
    Subscription.find_by(question: self, user: user)
  end

  def subscribe_after_create
    subscribe(user)
  end
end
