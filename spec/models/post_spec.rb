require 'spec_helper'

describe Post do
  it "should return a title" do
    p = build(:post, title: "hello world")
    p.title.should eq "hello world"
  end
  it "should return a body" do
    p = build(:post, body: 'goodbye world')
    p.body.should eq 'goodbye world'
  end
  it "is invalid without a title" do
    p = build(:post, title: nil)
    p.should be_invalid
  end
  it "is invalid without a body" do
    p = build(:post, body: nil)
    p.should be_invalid
  end
  it "should belong to an admin user" do
    p = build(:post)
    p.admin_user.should_not be_nil
  end
end