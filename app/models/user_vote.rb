class UserVote < ActiveRecord::Base
  attr_accessible :value

  belongs_to :user, inverse_of: :user_votes
  belongs_to :link, inverse_of: :user_votes
end
