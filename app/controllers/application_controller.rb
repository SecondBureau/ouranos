class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :store_location, :unless => 'request.fullpath.downcase.sub("//", "/")[0..8].eql?("/refinery")'
  
  def after_sign_in_path_for(resource)
    pop_stored_location || '/'
  end
    
end
