class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.ip = request.remote_ip
    if @comment.save
      redirect_to post_path(@post, notice: "Comment was successfully created")
    else
      flash[:alert] = "Comment could not be created"
      render 'posts/show'
    end
  end
end
