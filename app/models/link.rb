class Link < ActiveRecord::Base
  attr_accessible :url, :title, :body, :user_id, :sub_ids

  validates :url, presence: true
  validates :title, presence: true
  validates :user, presence: true
  validate :belongs_to_some_sub?

  belongs_to :user, inverse_of: :links
  has_many :link_subs, dependent: :destroy
  has_many :subs, through: :link_subs, source: :sub

  private
    def belongs_to_some_sub?
      if self.sub_ids.empty?
        self.errors[:sub_ids] = "Link must belong to at least one sub!"
      end
    end
end