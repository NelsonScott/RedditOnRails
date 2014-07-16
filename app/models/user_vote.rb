class UserVote < ActiveRecord::Base
  validates :user, :link, presence: true
  # don't let the user vote twice!
  validates :link_id, uniqueness: { scope: :user_id}

  belongs_to :user, inverse_of: :user_votes
  belongs_to :link, inverse_of: :user_votes
end
