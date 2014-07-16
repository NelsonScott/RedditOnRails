class Link < ActiveRecord::Base
  validates :title, :user, presence: true

  has_many :link_subs, inverse_of: :link, dependent: :destroy
  has_many :subs, through: :link_subs, source: :sub
  has_many :comments, inverse_of: :link
  has_many :user_votes, inverse_of: :link

  belongs_to(
    :submitter,
    foreign_key: :user_id
    inverse_of: :links
  )

  def comments_by_parent
    comments_by_parent = Hash.new { |hash, key| hash[key] = [] }

    comments.each do |comment|
      comments_by_parent[comment.parent_comment_id] << comment
    end

    comments_by_parent
  end

  def votes
    self.user_votes.sum(:value)
  end
end
