module BuildExtension
  def build(params)
    object = super(params)
    object.link = proxy_association.owner.link

    object
  end

  def create!(params)
    object = build(params)
    object.save!
  end
end

class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :parent_comment_id

  validates :body, presence: true

  belongs_to :link, inverse_of: :comments
  belongs_to :user, inverse_of: :comments

  has_many( :child_comments,
            class_name: "Comment",
            foreign_key: :parent_comment_id,
            primary_key: :id,
            extend: BuildExtension)
  belongs_to :parent_comment, class_name: "Comment", foreign_key: :parent_comment_id, primary_key: :id
end