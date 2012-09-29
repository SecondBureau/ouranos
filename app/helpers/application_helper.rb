module ApplicationHelper

def banner_image_url
  if Rails.env.production? && setting && setting.images[Random.rand(setting.images.length)]
    rand_index = Random.rand(setting.images.length)
    setting.images[rand_index].image.url(:banner_image)
  else
    "home_image.jpg"
  end
end

def link_to_switch_locale( locale )
  uparams = params.dup
  uparams[:locale] = locale
  link_to image_tag("flags/#{locale}.png"), refinery.url_for(uparams.merge(:only_path => true )), {:title => locale}
end

end
