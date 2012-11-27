require 'spec_helper'

describe AdminUser do
  it "should have a username" do
    u = build(:admin_user)
    u.username.should_not be_nil
  end
  it "should have a unique username" do
    u = create(:admin_user)
    u2 = build(:admin_user, username: u.username)
    u2.should_not be_valid
  end
  it "should be invalid without a username" do
    u = build(:admin_user, username: nil)
    u.should_not be_valid
  end
end