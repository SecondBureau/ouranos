class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  before_filter :set_locale, :ready_resources
  
  helper_method :available_locales, :current_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end
  
  def after_sign_up_path_for(resource)
      stored_location_for(resource) || main_app.member_confirming_path
  end

  private
    def default_url_options(options={})
      {:locale => I18n.locale }
    end

    def current_locale
      params[:locale] || I18n.locale
    end
  
    def available_locales
      $available_locales || ["fr"]
    end
  
    def set_locale
      I18n.locale = params[:locale] if available_locales.include?(params[:locale])
      I18n.locale = available_locales.first unless available_locales.include?(I18n.locale.to_s)
    end

    def ready_resources
      @pages = Page.all
      @categories_top = Category.where(:shows_at => :top)
      @latest_posts = Post.where(:is_pinned => false).limit(5)
      @pinned_posts = Post.where(:is_pinned => true);
      
      @most_posts = Post.limit(5)
      @categories_side = Category.where(:shows_at => :left)
      @recent_comments = Comment.limit(5)
      @comming_events = Event.limit(5)
      
      calendar_events
    end
    
    def calendar_events
      calendar_option = params[:calendar_option] if params[:calendar_option]
      if params[:year] 
        year = params[:year].to_i 
      else 
        year = DateTime.now.year
      end
      if params[:month] 
        month = params[:month].to_i 
      else 
        month = DateTime.now.month
      end
      @current_date = DateTime.new(year, month, 1)
      if calendar_option
        if calendar_option == "pre"
          @current_date = @current_date - 1.month
        elsif calendar_option == "next"
          @current_date = @current_date + 1.month
        end
      end
      
      @beginning_of_month = DateTime.new(@current_date.year, @current_date.month, 1)
      @end_of_month       = DateTime.new(@current_date.year, @current_date.month, -1)
      events_in_this_month = Event.where(:start_date => @beginning_of_month.beginning_of_day .. @end_of_month.end_of_day)
      @events_day = []
      events_in_this_month.each do |event|
        @events_day << event.start_date.day
      end
      @current_day = DateTime.now
    end

end
