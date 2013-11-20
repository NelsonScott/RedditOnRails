require 'spec_helper'

describe User do

  it "shouldn't allow mass assignment of password_digest" do
    expect { User.new(password_digest: "password") }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

  it "should create a password digest when a password is given" do
    user = FactoryGirl.build(:user)

    expect(user.password_digest).to_not be_nil
  end

  it "should create a session token after initialization of a user object" do
    user = FactoryGirl.build(:user)

    expect(user.session_token).to_not be_nil
  end

  it "should reset session token when asked" do
    user = FactoryGirl.create(:user)
    old_session_token = user.session_token
    user.reset_session_token!

    # Miniscule chance this will fail.
    expect(user.session_token).to_not eq(old_session_token)
  end

  it "should correctly verify a user's password" do
    user = FactoryGirl.build(:user, password: "password")

    expect(user.is_password?("password")).to be_true
  end

  it { should have_many(:subs) }
  it { should have_many(:links) }
  it { should have_many(:user_votes) }
  it { should have_many(:comments) }
end