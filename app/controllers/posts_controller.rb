class PostsController < ApplicationController

  before_filter :authenticate_user!, :is_membership_expired?, :check_member_confirmation

  def index
    locale = params[:post_locale] if params[:post_locale]
    locale = params[:locale] if !params[:post_locale]
  	if params[:category_id]
  		@category =  Category.find(params[:category_id])
  		@posts = @category.posts.locale_posts(locale).page(params[:page]).per(10)
		else
			@posts = Post.locale_posts(locale).page(params[:page]).per(10)
  	end
  end

  def show
    @post = Post.where("permalink = ?", params[:permalink]).first
    @post.read_count = @post.read_count + 1
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

