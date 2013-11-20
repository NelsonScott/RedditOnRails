require 'spec_helper'

describe Link do
  it "knows who its owner is via inverse_of" do
    user = FactoryGirl.build(:user)
    link = user.links.new

    expect(link.user).to be(user)
  end

  it "should create an appropriate comments hash"

  it { should have_many(:comments) }
  it { should have_many(:user_votes) }
  it { should have_many(:subs) }

  it { should validate_presence_of(:subs) }
end