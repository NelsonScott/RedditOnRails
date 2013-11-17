require 'spec_helper'

describe User do

  it "shouldn't store the raw password under a password column" do
    user = FactoryGirl.build(:user)

    expect { user.password }.to raise_error(NoMethodError)
  end

  it "shouldn't store the raw password in password_digest" do
    user = FactoryGirl.build(:user, password: "password")

    # If we don't call to_s it compares the BCrypt object.
    expect(user.password_digest.to_s).to_not eq("password")
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
end