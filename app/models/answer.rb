class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :body, :question_id, :user_id, presence: true

  include Attachable

  scope :ordered, -> { order(:created_at) }

  def make_best
    Answer.transaction do
      question.answers.update_all(best: false)
      update_attribute(:best, true)
    end
  end
end
