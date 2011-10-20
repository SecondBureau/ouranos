class CategoriesController < ApplicationController

  before_filter :authenticate_user!

  def index
  	@categories = Category.all
  end
  
  def show
  	@category = Category.find params[:id]
  end

end
