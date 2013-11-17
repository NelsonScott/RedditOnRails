class LinkSub < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :link
  belongs_to :sub
end
