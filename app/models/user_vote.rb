class UserVote < ActiveRecord::Base
  validates :user, :link, presence: true

  belongs_to :user, inverse_of: :user_votes
  belongs_to :link, inverse_of: :user_votes
end

