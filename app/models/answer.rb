class Answer < ActiveRecord::Base
  include Attachable
  include Votable
  include Commentable

  belongs_to :question
  belongs_to :user
  validates :body, :question_id, :user_id, presence: true

  scope :ordered, -> { order(:created_at) }

  def make_best
    Answer.transaction do
      question.answers.update_all(best: false)
      update_attribute(:best, true)
    end
  end
end
