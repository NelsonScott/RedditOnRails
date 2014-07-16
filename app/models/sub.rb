class Sub < ActiveRecord::Base
  validates :name, :moderator, presence: true
  validates :name, uniqueness: true

  has_many :link_subs, inverse_of: :sub, dependent: :destroy
  has_many :links, through: :link_subs, source: :link

  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id,
    inverse_of: :subs
  )
end
