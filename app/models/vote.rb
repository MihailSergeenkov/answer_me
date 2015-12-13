class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: [:votable_type, :votable_id] }
  validates :value, inclusion: { in: [1, -1] }

  scope :votes_up,    -> { where(value: 1) }
  scope :votes_down,  -> { where(value: -1) }
  scope :rating,      -> { sum(:value) }
end
