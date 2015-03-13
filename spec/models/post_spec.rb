require 'rails_helper'

describe Post do
  it "is valid with title, url, and description" do
    expect(build(:post)).to be_valid
  end

  it "is invalid without a title" do
    expect(build(:post, title: nil)).not_to be_valid
  end

  it "is invalid without a url" do
    expect(build(:post, url: nil)).not_to be_valid
  end

  it "is invalid without a description" do
    expect(build(:post, url: nil)).not_to be_valid
  end

end
