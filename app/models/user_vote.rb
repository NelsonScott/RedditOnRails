class UserVote < ActiveRecord::Base
  validates :user, :post, presence: true
  # don't let the user vote twice!
  validates :post_id, uniqueness: { scope: :user_id}

  belongs_to :user, inverse_of: :user_votes
  belongs_to :post, inverse_of: :user_votes
end
