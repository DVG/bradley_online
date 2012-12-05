class Comment < ActiveRecord::Base
  attr_accessible :body, :email, :ip, :name, :website
  validates_presence_of :email, :name, :body
  belongs_to :post, 
             :counter_cache => :comments_count
end
