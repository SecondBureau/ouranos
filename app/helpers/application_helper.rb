module ApplicationHelper
  
  def link_to_switch_locale( locale )
    uparams = params.dup
    uparams[:locale] = locale
    link_to image_tag("flags/#{locale}.png"), main_app.url_for( uparams.merge(:only_path => true )), {:title => locale}
  end
  
  def num_to_month_name month_num
    t("date.month_names")[month_num].capitalize
  end
  
end
