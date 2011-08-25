class CommentsController < ApplicationController
  
  before_filter :check_user_role
  
  def create
    @comment = Comment.create params[:comment]
    if @comment.errors.any?
      redirect_to main_app.post_path(@comment.post), :alert => @comment.errors
    elsif(%w{member officer admin}.include? current_user.role.name)
      @comment.is_valid = true
      @comment.save
      redirect_to main_app.post_path(@comment.post), :notice => t("comment.valid.added")
    else
      @comment.is_valid = false
      @comment.save
      redirect_to main_app.post_path(@comment.post)
    end
  end
  
private
  def check_user_role
    if(current_user.role.name == "guests")
      redirect_to main_app.post_path(params[:comment][:post_id]), :notice => "Please login to comment an article!"
    end
  end

end
