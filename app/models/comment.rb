class Comment < ActiveRecord::Base

  validates :body, presence: true
  validates :user, presence: true
  validates :link, presence: true

  belongs_to :link, inverse_of: :comments
  belongs_to :user, inverse_of: :comments

  has_many( :child_comments,
            class_name: "Comment",
            foreign_key: :parent_comment_id,
            primary_key: :id)
  belongs_to :parent_comment, class_name: "Comment", foreign_key: :parent_comment_id, primary_key: :id
end