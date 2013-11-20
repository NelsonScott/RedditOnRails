require 'spec_helper'

describe Sub do
  it "knows a sub without a moderator is invalid" do
    sub = FactoryGirl.build(:sub)

    expect(sub).to have(1).error_on(:moderator)
  end

  it { should validate_presence_of(:moderator) }

  it "associates with the correct moderator even before save" do
    user = FactoryGirl.build(:user)
    sub = user.subs.new(name: "sub")

    expect(sub.moderator).to be(user)
  end

  it "does not allow moderator_id to be mass assigned" do
    expect { Sub.new(moderator_id: 1) }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

  it { should belong_to(:moderator) }

  it { should have_many(:links) }
end