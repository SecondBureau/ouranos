class ManagementsController < ApplicationController
  
  before_filter :check_user_role
  
  def index
    @user_count = User.all.size
    @member_count = User.members.size
  end
  
  def show
    case params[:oper]
    when "user"
      @users = User.all
    when "post"
    when "survey"
    end
    render params[:oper]
  end
  
  def detail
    case params[:oper]
    when "user"
      @user = User.find params[:id]
    when "post"
      @post = Post.find params[:id]
    when "survey"
      @survey = Survey.find params[:id]
    end
    render params[:oper] + "_detail"
  end
  
private
  def check_user_role
    if(%w{guests users}.include? current_user.role.name)
      redirect_to main_app.root_path, :notice => "Can't find that page!"
    end
  end

end
