module ApplicationHelper

  def banner_image_url
      "home_image.jpg"
  end
  
  def fullname (user)
    unless user.firstname.blank? && user.lastname.blank?
      [user.firstname, user.lastname].join(' ')
    else
      user.username
    end
  end
  
  def probably_uptodate(date)
    date > Time.new(Time.now.year, 8, 15)
  end
  
  # Menu Helper not included in Groups Controller...
  def link_to_switch_locale( locale, trigger=false )
    uparams = params.dup
    uparams[:locale] = locale
    options = {:title => locale}
    options = options.merge({:class => "dropdown-toggle locale-switcher", :"data-toggle" => "dropdown", :"data-target" => "#" }) if trigger
    link_to "#{image_tag("flags/#{locale}.png")}#{trigger ? '<b class=\'caret\'></b>' : ''}".html_safe, refinery.url_for(uparams.merge(:only_path => true )), options
  end

end
