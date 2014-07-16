class Comment < ActiveRecord::Base
  validates :body, :user, :post, presence: true

  belongs_to :post, inverse_of: :comments
  belongs_to :user, inverse_of: :comments

  has_many :child_comments,
              class_name: "Comment",
              foreign_key: :parent_comment_id,
              primary_key: :id

  belongs_to :parent_comment,
              class_name: "Comment",
              foreign_key: :parent_comment_id,
              primary_key: :id
end
