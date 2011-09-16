class CommentsController < ApplicationController
  
  def create
    @comment = Comment.create params[:comment]
    post = Post.find @comment.commentable_id
    if @comment.errors.any?
      redirect_to main_app.post_path(post), :alert => @comment.errors
    elsif(%w{member officer admin}.include? current_user.role.name)
      @comment.is_valid = true
      @comment.save
      redirect_to main_app.post_path(post), :notice => t("comment.valid.added")
    else
      @comment.is_valid = false
      @comment.save
      redirect_to main_app.post_path(post)
    end
  end

end
