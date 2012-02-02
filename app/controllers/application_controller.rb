class ApplicationController < ActionController::Base

  require 'daryl'

  protect_from_forgery

  before_filter :set_locale
  before_filter :set_ga_custom_value, :set_ga_custom_name

  helper_method :available_locales, :current_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  def is_membership_expired?
    redirect_to(main_app.root_path) if (!current_user || current_user.is_expired?)
  end

  def check_member_confirmation

  end

  private
    def default_url_options(options={})
      {:locale => I18n.locale }
    end

    def current_locale
      params[:locale] || I18n.locale
    end

    def available_locales
      $available_locales || ["fr"]
    end

    def set_locale
      I18n.locale = params[:locale] if available_locales.include?(params[:locale])
      I18n.locale = available_locales.first unless available_locales.include?(I18n.locale.to_s)
    end



    

    def anonymous_id
      session[:anonymous_id] ||= (10000 + rand(100000))
    end

    def compound_metric_name
      'page_view'
    end

    def restful_metrics_application_identifier
      'app1531543'
    end

    def count_static_page
      begin
        RestfulMetrics::Client.add_compound_metric(restful_metrics_application_identifier, compound_metric_name, 'info', current_user ? current_user.id : anonymous_id) if $restful_metrics_api_key
      rescue
      end
    end

    def count_post_page
      begin
      RestfulMetrics::Client.add_compound_metric(restful_metrics_application_identifier, compound_metric_name, 'post') if $restful_metrics_api_key
      rescue
      end
    end

    def count_event_page
      begin
      RestfulMetrics::Client.add_compound_metric(restful_metrics_application_identifier, compound_metric_name, 'event') if $restful_metrics_api_key
      rescue
      end
    end

    def ga_custom
      @ga_custom ||= {}
    end

    def set_ga_custom_name
      ga_custom[:name] = 'section'
    end

  def set_ga_custom_value
    ga_custom[:value] = 'other'
  end

end
