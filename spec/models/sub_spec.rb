require 'spec_helper'

describe Sub do
  it "associates with the correct moderator even before save via inverse_of" do
    user = FactoryGirl.build(:user)
    sub = user.subs.new(name: "sub")

    expect(sub.moderator).to be(user)
  end

  # it "does not allow moderator_id to be mass assigned" do
  #   expect { Sub.new(moderator_id: 1) }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  # end

  it { should_not allow_mass_assignment_of :moderator_id }

  it { should belong_to(:moderator) }

  it { should have_many(:links) }
end