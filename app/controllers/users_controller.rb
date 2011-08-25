class UsersController < ApplicationController
  
  def index
  end
  
  def show
    case params[:oper]
    when "informations"
    when "membership"
    when "subscribes"
      @subscribes = "subscribes"
    when "settings"
      @settings = "settings"
    end
    render params[:oper]
  end
  
  def edit
    @user = User.find params[:id]
  end
  
  def update
    User.update(params[:id], params[:user])
    redirect_to main_app.user_oper_path(current_user, "informations"), :notice => "Update information successfully!"
  end

end
