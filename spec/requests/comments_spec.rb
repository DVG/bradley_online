require 'spec_helper'

describe "Comments" do
  context "front of the house" do
    describe "new comment" do
      before :each do
        @post = create(:post)
      end
      
      it "creates a new comment" do
        visit post_path(@post)
        data = {
          name: "George",
          email: "user@example.com",
          body: "Hello World"
        }
        fill_in "comment_name", with: data[:name]
        fill_in "comment_email", with: data[:email]
        fill_in "comment_body", with: data[:body]
        click_button "Create Comment"
        comment = Comment.last
        comment.name.should eq data[:name]
        comment.email.should eq data[:email]
        comment.body.should eq data[:body]
      end
      it "shows an error when user doesn\'t enter a name" do
        visit post_path(@post)
        data = {
          name: "George",
          email: "user@example.com",
          body: "Hello World"
        }
        fill_in "comment_email", with: data[:email]
        fill_in "comment_body", with: data[:body]
        click_button "Create Comment"
        page.should have_content "Comment could not be created"
      end
      it "shows an error when user doesn\'t enter an email" do
        visit post_path(@post)
        data = {
          name: "George",
          email: "user@example.com",
          body: "Hello World"
        }
        fill_in "comment_name", with: data[:name]
        fill_in "comment_body", with: data[:body]
        click_button "Create Comment"
        page.should have_content "Comment could not be created"
      end
      it "shows an error when user doesn\'t enter a body" do
        visit post_path(@post)
        data = {
          name: "George",
          email: "user@example.com",
          body: "Hello World"
        }
        fill_in "comment_name", with: data[:name]
        fill_in "comment_email", with: data[:email]
        click_button "Create Comment"
        page.should have_content "Comment could not be created"
      end
      it "logs the users ip address" do
        visit post_path(@post)
        data = {
          name: "George",
          email: "user@example.com",
          body: "Hello World"
        }
        fill_in "comment_name", with: data[:name]
        fill_in "comment_email", with: data[:email]
        fill_in "comment_body", with: data[:body]
        click_button "Create Comment"
        comment = Comment.last
        comment.ip.should_not be_nil
      end
      it "displays the comment name when viewing the post" do
        comment = create(:comment)
        visit post_path(comment.post)
        within "#comments" do
          page.should have_content comment.name
        end
      end
      it "displays the comment body when viewing the post" do
        comment = create(:comment)
        visit post_path(comment.post)
        within "#comments" do
          page.should have_content comment.body
        end
      end
      it "displays an informational message if there are no comments" do
        visit post_path(@post)
        within "#comments" do
          page.should have_content "There are no comments, be the first person to comment below!"
        end
      end
      it "displays a comment count on the index page" do
        create(:comment, post: @post)
        visit posts_path(@post)
        page.should have_link "Comments (1)"
      end
    end
  end
end