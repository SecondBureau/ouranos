class CommentsController < ApplicationController
  
  def create
    @comment = Comment.create params[:comment]
    redirect_to main_app.post_path(@comment.post), :notice => "add a new comment"
  end

end
