class PagesController < ApplicationController

  after_filter :count_static_page


  def index
    @latest_posts = PostDecorator.decorate(Post.where(:is_pinned => false).limit(5))
    @pinned_posts = PostDecorator.decorate(Post.where(:is_pinned => true))
    if params[:calendar_option]
      calendar_events
      respond_to do |format|
    	  format.js {render "calendar"}
	    end
    end
  end

  def show
    @page = Page.find_by_permalink params[:permalink]
    @pages = Page.all
  end

  private

  def set_ga_custom_value
    ga_custom[:value] = 'info'
  end

end
