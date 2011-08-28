class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  before_filter :set_locale, :ready_pages
  
  helper_method :available_locales, :display_locales , :current_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end


  private
    def default_url_options(options={})
      {:locale => I18n.locale }
    end

    def current_locale
      params[:locale] || I18n.locale
    end
  
    def available_locales
      $available_locales || ["en"]
    end
  
    def display_locales
      available_locales.length > 1
    end
  
    def set_locale
      I18n.locale = params[:locale] if available_locales.include?(params[:locale])
      I18n.locale = available_locales.first unless available_locales.include?(I18n.locale.to_s)
    end

    def ready_pages
      if(current_user == nil|| current_user.is_of_role?(:user))
        @pages = Page.public_pages
      else
        @pages = Page.all
      end
    end

end
