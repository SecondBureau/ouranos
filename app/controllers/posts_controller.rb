class PostsController < ApplicationController
  
  def index
    if !current_user || current_user.is_of_role?(:user)
      @posts = Post.public_posts.page(params[:page]).per(10)
    else
      @posts = Post.page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.where("permalink = ?", params[:permalink]).first
    @comment = @post.comments.build
    @comment.is_valid = 0
    @comments = @post.comments.valid
    @comments_size = @comments.size
    if !current_user
      @has_unvalid_commented = false
    elsif(current_user.is_of_role?(:user) && @post.comments.unvalid(current_user).size > 0)
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
