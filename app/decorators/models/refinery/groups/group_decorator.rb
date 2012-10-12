Refinery::Groups::Group.class_eval do 
  
  def expired?
    expiration_date < Time.zone.today
  end
  
end