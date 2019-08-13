class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.post_id = params[:post_id]
    comment.author_id = current_user.id

    if comment.save
      redirect_to post_url(params[:post_id])
    else
      flash[:errors] = comment.errors.full_messages
      redirect_to post_url(params[:post_id])
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
