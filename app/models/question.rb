class Question < ActiveRecord::Base
  include Attachable
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, :body, :user_id, presence: true
  validates :title, length: { maximum: 100 }
end
