class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :available_locales, :display_locales , :current_locale

  before_filter :set_locale
  before_filter :create_account_for_guest
 before_filter :meta_defaults

  private 
  
  def default_url_options(options={})
    {:locale => I18n.locale}
  end

  def current_locale
    params[:locale] || I18n.locale
  end

  def available_locales
    $available_locales || ["fr"]
  end

  def display_locales
    available_locales.length > 1
  end

  def set_locale
    I18n.locale = params[:locale] if available_locales.include?(params[:locale])
    I18n.locale = available_locales.first unless available_locales.include?(I18n.locale.to_s)
  end

  def create_account_for_guest
    if !!!current_account or !!!current_user
      @current_account ||= RorshackAuthentication::Account.find_by_email("guest@secondbureau.com")
      @current_account_session = RorshackAuthentication::AccountSession.create(current_account)
    end
    current_account
  end

  #
  # SEO
  #
  def meta_defaults
    # @page_title = Setting.local_value('title') || ''
    # @page_keywords = (Setting.local_value('keywords') || '').split(', ').shuffle.join(', ')
    # @page_description = Setting.local_value('description') || ''
  end

  def display_locales
    false
  end

end