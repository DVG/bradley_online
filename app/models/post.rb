class Post < ActiveRecord::Base
  attr_accessible :body, :title, :admin_user_id
  validates_presence_of :body
  validates_presence_of :title
  belongs_to :admin_user
end
