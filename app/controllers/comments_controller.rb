class CommentsController < ApplicationController
  
  def create
    @comment = Comment.create params[:comment]
    post = Post.find @comment.commentable_id
    if @comment.errors.any?
      redirect_to main_app.post_path(post), :alert => @comment.errors
    else
      redirect_to main_app.post_path(post), :notice => t("comment.valid.added")
    end
  end

end
