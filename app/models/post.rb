class Post < ActiveRecord::Base
  validates :submitter, :title, presence: true

  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments, inverse_of: :post
  has_many :user_votes, inverse_of: :post

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :user_id,
    inverse_of: :posts
  )

  def comments_by_parent
    comments_by_parent = Hash.new { |hash, key| hash[key] = [] }

    self.comments.each do |comment|
      comments_by_parent[comment.parent_comment_id] << comment
    end

    comments_by_parent
  end

  def votes
    self.user_votes.sum(:value)
  end
end
