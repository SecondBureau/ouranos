Refinery::Groups::Group.class_eval do 
  
  def expired?
    expiration_date < Date.today
  end
  
end