module ApplicationHelper
  
  def link_to_switch_locale( locale )
    uparams = params.dup
    uparams[:locale] = locale
    link_to image_tag("flags/#{locale}.png"), main_app.url_for( uparams.merge(:only_path => true )), {:title => locale}
  end
  
  def num_to_month_name month_num
    t("date.month_names")[month_num].capitalize
  end
  
  def most_posts
    @most_posts ||= PostDecorator.decorate(Post.top_posts)
  end
  
  def categories_side
    @categories_side ||= CategoryDecorator.decorate(Category.on_the(:left))
  end
  
  def recent_comments
    @recent_comments ||= CommentDecorator.decorate(Comment.recent_comments)
  end
  
  def categories_top
    @categories_top ||= CategoryDecorator.decorate(Category.on_the(:top))
  end
  
  def comming_events     
    @comming_events ||= EventDecorator.decorate(Event.comming_events)
  end
  
  def top_pages
    @top_pages ||= Page.all
  end
  
  def setting
    @setting ||= Setting.first
  end
  
  def banner_image_url
    if Rails.env.production? && setting && setting.images[Random.rand(setting.images.length)]
      rand_index = Random.rand(setting.images.length)
      setting.images[rand_index].image.url(:banner_image)
    else
      "home_image.jpg"
    end
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
