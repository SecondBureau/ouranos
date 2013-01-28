Refinery::Groups::Group.class_eval do 
  
  def expired?
    expiration_date < Time.zone.today
  end
  
  def add_user user
    users << user
    #user.subscribe
  end
  
end
