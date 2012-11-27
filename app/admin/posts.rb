ActiveAdmin.register Post do
  index do
    column :title do |p|
      link_to p.title, admin_post_path(p)
    end
    column :body
    column :created_at
    column :updated_at
  end
  
  
  form :partial => "form"
  
  controller do
    def create
      @post = Post.new(params[:post])
      @post.admin_user = current_admin_user
      create!
    end
  end
end
