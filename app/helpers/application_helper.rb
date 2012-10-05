module ApplicationHelper

  def banner_image_url
    if Rails.env.production? && setting && setting.images[Random.rand(setting.images.length)]
      rand_index = Random.rand(setting.images.length)
      setting.images[rand_index].image.url(:banner_image)
    else
      "home_image.jpg"
    end
  end
  
  def fullname (user)
    unless user.firstname.blank? && user.lastname.blank?
      [user.firstname, user.lastname].join(' ')
    else
      user.username
    end
  end
  
  def probably_uptodate(date)
    date > Time.new(Time.now.year, 9, 15)
  end

end
