class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  validates :body, :question_id, :user_id, presence: true

  scope :ordered, -> { order(:created_at) }

  accepts_nested_attributes_for :attachments

  def make_best
    Answer.transaction do
      question.answers.update_all(best: false)
      update_attribute(:best, true)
    end
  end
end
