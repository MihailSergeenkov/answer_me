class Answer < ActiveRecord::Base
  include Attachable
  include Votable
  include Commentable

  belongs_to :question, touch: true
  belongs_to :user
  validates :body, :question_id, :user_id, presence: true

  scope :ordered, -> { order(:created_at) }

  after_create :notification_question_subscribers

  def make_best
    Answer.transaction do
      question.answers.update_all(best: false)
      update_attribute(:best, true)
    end
  end

  private

  def notification_question_subscribers
    NotificationQuestionSubscribersJob.perform_later(self)
  end
end
