require 'spec_helper'

describe 'Posts' do
  context 'front of the house' do
    before :each do
      @post = create(:post)
    end
    it "should display the post titles on the index page" do
      visit posts_path
      page.should have_content @post.title
    end
    it "should display the post body on the index page" do
      visit posts_path
      page.should have_content @post.body
    end
    it "should display the post title on the show page" do
      visit post_path(@post)
      page.should have_content @post.title
    end
    it "should display the post body on the show page" do
      visit post_path(@post)
      page.should have_content @post.body
    end
  end
  context 'Admin' do
    before :each do
      @admin = create(:admin_user)
      visit new_admin_user_session_path
      fill_in "admin_user_email", :with => @admin.email
      fill_in "admin_user_password", :with => @admin.password
      click_button "Login"
    end
    context "Post" do
      it "should assign the current admin to admin_user when creating a post" do
        visit admin_posts_path
        click_link "New Post"
        fill_in "post_title", :with => 'Didactically speaking'
        fill_in "post_body", :with => "Hi there ho there"
        click_button 'Create Post'
        Post.last.admin_user.should eq @admin
      end
      context "Markdown Helpers" do
        
        describe "italics" do
          it "should have an i link" do
            visit new_admin_post_path
            within "#toolbar" do
              page.should have_link "i"
            end
          end
          it "should wrap selected text in *", js: true do
            visit new_admin_post_path
            fill_in "post_body", :with => "Hello World"
            page.execute_script %Q{ $('#post_body').select() } 
            click_link "i"
            find("#post_body")[:value].should eq "*Hello World*"
          end
        end
        
        describe "bold" do
          it "should have a b link" do
            visit new_admin_post_path
            within "#toolbar" do
              page.should have_link "b"
            end
          end
          it "should wrap selected test in **", js: true do
            visit new_admin_post_path
            fill_in "post_body", :with => "Hello World"
            page.execute_script %Q{ $('#post_body').select() } 
            click_link "b"
            find("#post_body")[:value].should eq "**Hello World**"
          end
        end
        
        
        describe "code" do
          it "should have a code link" do
            visit new_admin_post_path
            within "#toolbar" do
              page.should have_link "code"
            end
          end
          it "wraps selected text in ~~~", js: true do
            visit new_admin_post_path
            fill_in "post_body", :with => "Hello World"
            page.execute_script %Q{ $('#post_body').select() } 
            click_link "code"
            find("#post_body")[:value].should eq "~~~\nHello World\n~~~"
          end
        end
        
        describe "inline code", focus: true do
          it "should have an inline code link" do
            visit new_admin_post_path
            within "#toolbar" do
              page.should have_link "inline code"
            end
          end
          it "should wrap selected text in `", js: true do
            visit new_admin_post_path
            fill_in "post_body", :with => "Hello World"
            page.execute_script %Q{ $('#post_body').select() } 
            click_link "inline code"
            find("#post_body")[:value].should eq "`Hello World`"
          end
        end
        
        describe "quote" do
          it "should have a quote link" do
            visit new_admin_post_path
            within "#toolbar" do
              page.should have_link "quote"
            end
          end
          it "inserts > at the beginning of the selected line", js: true do
            visit new_admin_post_path
            fill_in "post_body", :with => "Hello World"
            page.execute_script %Q{ $('#post_body').select() } 
            click_link "quote"
            find("#post_body")[:value].should eq "> Hello World"
          end
        end
        
        it "inserts a > after each newline", js: true do
          visit new_admin_post_path
          fill_in "post_body", :with => "Hello World\nYes Hello"
          page.execute_script %Q{ $('#post_body').select() } 
          click_link "quote"
          find("#post_body")[:value].should eq "> Hello World\n> Yes Hello"
        end
        
      end
    end
  end
end