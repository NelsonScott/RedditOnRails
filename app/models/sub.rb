class Sub < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true
  validates :moderator, presence: true

  belongs_to :moderator, class_name: "User", foreign_key: :moderator_id, primary_key: :id, inverse_of: :subs
  has_many :link_subs, dependent: :destroy
  has_many :links, through: :link_subs, source: :link
end