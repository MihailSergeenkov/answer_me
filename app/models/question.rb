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

  def subscribe(user)
    Subscription.create(question: self, user: user) unless question_subscribtion(user)
  end

  def unsubscribe(user)
    question_subscribtion(user).destroy if question_subscribtion(user)
  end

  def question_subscribtion(user)
    Subscription.find_by(question: self, user: user)
  end
end
