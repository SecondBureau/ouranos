class WidgetsController < ActionController::Base
  
  include ActionView::Helpers::TextHelper
  
  layout false

  
  def show

    @widget = params[:id]
    @latest_post_etag = params[:po]
    @latest_event_etag = params[:e]
    @latest_page_etag = params[:pa]
    
    case @widget
    when 'calendar', 'events_of_day'
      @day = Time.zone.parse(params[:d]) rescue Time.zone.now
    end

    case params[:s]
    when 'home'
      @widgets = %w[calendar categories popular_posts recent_comments contact]
      if Refinery::Page.modal_notice && Time.now.to_i > (cookies[:modal_notice_timestamp].to_i + 86400)
        @widgets << 'modal_notice' 
        cookies[:modal_notice_timestamp] = Time.now.to_i
      end
      if current_refinery_user 
        @widgets << 'membership_status'
      end
    else
      @widgets = %w[calendar categories popular_posts recent_comments contact]
    end

    if File.exist?(Rails.root.join('app', 'views', 'widgets', "#{@widget}.html.haml"))
      @post_updated_at = params[:v]
      render :action => @widget
    end

  end

end