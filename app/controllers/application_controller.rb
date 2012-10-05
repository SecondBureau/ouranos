class ApplicationController < ActionController::Base
  
  protect_from_forgery
    
  before_filter :store_location, :unless => 'request.fullpath.downcase.sub("//", "/")[0..8].eql?("/refinery")'
  before_filter :hide_dashboard_for_group_admins
  
  def after_sign_in_path_for(resource)
    pop_stored_location || '/'
  end
  
  private
  
  # dashboard is never hidden even if user doesn't have the pluging
  def hide_dashboard_for_group_admins
    Refinery::Plugins.registered.find_by_name("refinery_dashboard").hide_from_menu = true if current_refinery_user && current_refinery_user.has_role?("GroupAdmin")
  end
    
end
