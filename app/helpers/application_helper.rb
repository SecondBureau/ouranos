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
  

  
end
