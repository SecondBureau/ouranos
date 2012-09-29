class WidgetsController < ApplicationController

  include ActionView::Helpers::TextHelper
  
  layout false

  def show
    @widget = params[:id]
    if File.exist?(Rails.root.join('app', 'views', 'widgets', "#{@widget}.html.haml"))
      @post_updated_at = params[:v]
      render :action => @widget
    end
  end


end