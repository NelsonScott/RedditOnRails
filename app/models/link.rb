class Link < ActiveRecord::Base
  attr_accessible :url, :title, :body, :user_id, :sub_ids

  validates :url, presence: true
  validates :title, presence: true
  validates :user, presence: true
  validates :subs, presence: true

  belongs_to :user, inverse_of: :links
  has_many :link_subs, dependent: :destroy
  has_many :subs, through: :link_subs, source: :sub
  has_many :comments, inverse_of: :link

  has_many :user_votes, inverse_of: :link

  def comments_by_parent
    comments_by_parent = Hash.new { |hash, key| hash[key] = [] }

    comments.each do |comment|
      comments_by_parent[comment.parent_comment_id] << comment
    end

    comments_by_parent
  end
end