class PostsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
  	if params[:category_id]
  		@category =  Category.find(params[:category_id])
  		@posts = @category.posts.page(params[:page]).per(10)
		else
			@posts = Post.page(params[:page]).per(10)
  	end
  end

  def show
    @post = Post.where("permalink = ?", params[:permalink]).first
    @post.readed = @post.readed + 1
    @post.save
    @comments = @post.comments
    @comments_size = @comments.size
    @comment = @post.comments.build
    @comments.delete @comment
  end
  
  def with_category
  	@posts = Category.find params[:id]
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
