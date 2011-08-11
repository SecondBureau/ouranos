class PostsController < ApplicationController
  
  def index
    if(current_user.is_of_role?(:guests))
      @posts = Post.public_posts.order("created_at DESC").page(params[:page]).per(10)
    else
      @posts = Post.order("created_at DESC").page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find params[:id]
    @comment = @post.comments.build
    @comment.is_valid = 0
    @comments = @post.comments.valid
    @comments_size = @comments.size
    if(current_user.role.name == "users" && @post.comments.has_unvalid_commented(current_user).size > 0)
      @has_unvalid_commented = true
    end
  end
  
  def print
    @post = Post.find params[:id]
    render :layout => false
  end
  
  def to_pdf
    kit = PDFKit.new("www.google.com")
    kit.to_pdf
  end

end
