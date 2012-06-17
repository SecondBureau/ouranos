class PostsController < ApplicationController

  before_filter :authenticate_user!, :is_membership_expired?, :check_member_confirmation
  after_filter :count_post_page

  def index
    locale = params[:post_locale] if params[:post_locale]
    locale = current_locale if !params[:post_locale]
  	if params[:category_id]
  		@category =  Category.find(params[:category_id])
  		@posts = @category.posts.locale_posts(locale).page(params[:page]).per(10)
		else
			@posts = Post.default_order.locale_posts(locale).page(params[:page]).per(10)
  	end
		@posts = PostDecorator.decorate(@posts)
		respond_to do |format|
		  format.html
      format.rss { render :layout => false }
    end
  end

  def show
    @post = PostDecorator.decorate(Post.where("permalink = ?", params[:permalink]).first)
    @post.read_count = @post.read_count + 1
    #@post.save_without_expiring_cache
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

  private

  def set_ga_custom_value
    ga_custom[:value] = 'post'
  end

end
