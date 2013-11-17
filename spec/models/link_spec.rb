require 'spec_helper'

describe Link do
  it "knows who its owner is" do
    user = FactoryGirl.build(:user)
    link = user.links.new

    expect(link.user).to be(user)
  end

  it "knows it has many subs" do
    user = FactoryGirl.create(:user)
    link = FactoryGirl.build(:link, user_id: user.id)
    sub = link.subs.new(name: "A Sub")

    link.save

    expect(link.subs).to include(sub)
  end

  it "is invalid if it belongs to no subs" do
    user = FactoryGirl.create(:user)
    link = FactoryGirl.build(:link, user_id: user.id)
    expect(link).to_not be_valid
  end

  it "is valid if it does have at least one sub" do
    user = FactoryGirl.create(:user)
    sub = FactoryGirl.create(:sub, moderator_id: user.id)
    link = FactoryGirl.build(:link, user_id: user.id, sub_ids: [sub.id])

    expect(link).to be_valid
  end
end