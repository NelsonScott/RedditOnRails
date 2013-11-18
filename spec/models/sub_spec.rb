require 'spec_helper'

describe Sub do
  it "knows a sub without a moderator is invalid" do
    sub = FactoryGirl.build(:sub)

    expect(sub).to_not be_valid
  end

  it "knows a sub with a moderator is valid" do
    user = FactoryGirl.build(:user)
    sub = user.subs.new(name: "sub")

    expect(sub).to be_valid
  end

  it "associates with the correct moderator even before save" do
    user = FactoryGirl.build(:user)
    sub = user.subs.new(name: "sub")

    expect(sub.moderator).to be(user)
  end

  # Does this one test too much stuff at once?
  it "has_many links through link_subs" do
    user = FactoryGirl.create(:user)
    sub = user.subs.new(name: :sub)
    link = sub.links.new(url: "http://www.google.com", title: "Sweet search engine!")
    sub.save

    expect(sub.links).to include(link)
  end

  it "does not allow moderator_id to be mass assigned" do
    expect { Sub.new(moderator_id: 1) }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end
end