class ManagementsController < ApplicationController
  
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

end
