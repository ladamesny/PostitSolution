require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a username" do
    expect(build(:user, username: nil)).to be_invalid
  end

  it "is invalid without a password" do
    expect(build(:user, password: nil)).to be_invalid
  end

  it "does not allow duplication of usernames" do
    create(:user, username: "Batman335")
    user = build(:user, username: "Batman335")
    user.valid?
    expect(user.errors[:username]).to include('has already been taken')
  end

  context "Validates correctly when password" do
    it "is not at least 5 characters long" do
      expect(build(:user, password: "nope")).to be_invalid
    end

    it "is at least 5 characters long" do
      expect(build(:user, password: "yeppers")).to be_valid
    end
  end


end
