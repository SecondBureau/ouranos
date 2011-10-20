class PagesController < ApplicationController
  
  before_filter :authenticate_user!, :except => :index
  
  def index
  end
  
  def show
    @page = Page.find_by_permalink params[:permalink]
    @pages = Page.all
  end
  
end
