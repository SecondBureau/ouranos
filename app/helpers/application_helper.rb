module ApplicationHelper
  
  def link_to_switch_locale( locale )
    uparams = params.dup
    uparams[:locale] = locale
    link_to image_tag("flags/#{locale}.png"), main_app.url_for( uparams.merge(:only_path => true ))
  end
  
end
