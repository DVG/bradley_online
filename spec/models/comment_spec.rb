require 'spec_helper'

describe Comment do
  it "requires an email" do
    build(:comment, email: nil).should_not be_valid
  end
  it "requires a name" do
    build(:comment, name: nil).should_not be_valid
  end
  it "requires a body" do
    build(:comment, body: nil).should_not be_valid
  end
  it "belongs to a post" do
    create(:comment).post.should_not be_nil
  end
end
