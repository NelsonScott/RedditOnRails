class UserVote < ActiveRecord::Base
  attr_accessible :value, :user_id

  belongs_to :user, inverse_of: :user_votes
  belongs_to :link, inverse_of: :user_votes
end
