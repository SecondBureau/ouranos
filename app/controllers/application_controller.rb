class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :ready_pages

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end


  private

    def ready_pages
      if(current_user == nil|| current_user.is_of_role?(:user))
        @pages = Page.public_pages
      else
        @pages = Page.all
      end
    end

end
