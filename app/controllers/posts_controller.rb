class PostsController < ApplicationController
  
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(10)
  end

  def show
    @post = Post.find params[:id]
    @comment = @post.comments.build
    @comments = @post.comments.order("created_at DESC")
    @comments_size = @post.comments.size
  end
  
  def print
    @post = Post.find params[:id]
    render :layout => false
  end

end
