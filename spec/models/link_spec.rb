require 'spec_helper'

describe Link do
  it "knows who its owner is via inverse_of" do
    user = FactoryGirl.build(:user)
    link = user.links.new

    expect(link.user).to be(user)
  end

  it "should create an appropriate comments hash" do
    moderator = FactoryGirl.create(:user)
    sub = moderator.subs.create(name: "A sub!")

    link = Link.new(url: "URL", title: "TITLE")
    link.user = moderator
    link.subs = [sub]
    link.save

    comment = link.comments.build(body: "BODY")
    comment.user = moderator
    comment.save

    child_comment = comment.child_comments.build(body: "BODY 2")
    child_comment.link = link
    child_comment.user = moderator
    child_comment.save

    child_child_comment = child_comment.child_comments.build(body: "BODY 3")
    child_child_comment.link = link
    child_child_comment.user = moderator
    child_child_comment.save

    expect(link.comments_by_parent).to eq({
      nil => [comment],
      comment.id => [child_comment],
      child_comment.id => [child_child_comment]
    })
  end

  it { should have_many(:comments) }
  it { should have_many(:link_subs) }
  it { should have_many(:user_votes) }
  it { should have_many(:subs).through(:link_subs) }
end
