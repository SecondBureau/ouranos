class UsersController < ApplicationController
  
  before_filter :redirect_root_unless_is_current_user
  
  def index
  end
  
  def show
    @user = User.find params[:id]
  end
  
  def edit
    @user = User.find params[:id]
  end
  
  def update
    User.update(params[:id], params[:user])
    redirect_to main_app.user_path(current_user), :notice => "Update information successfully!"
  end
  
private
  def redirect_root_unless_is_current_user
    unless current_user == User.find(params[:id])
      redirect_to main_app.root_path, :notice => "Please log in to continue!"
    end
  end

end
