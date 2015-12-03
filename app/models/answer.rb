class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :body, :question_id, :user_id, presence: true

  def make_best
    question.answers.update_all(best: false)
    update_attribute(:best, true)
  end
end
