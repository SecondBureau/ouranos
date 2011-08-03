class PostsController < ApplicationController
  
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(10)
  end

  def show
    @post = Post.find params[:id]
  end

end
