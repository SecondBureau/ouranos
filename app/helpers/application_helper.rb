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

end
