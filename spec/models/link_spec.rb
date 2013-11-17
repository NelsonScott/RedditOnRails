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
end