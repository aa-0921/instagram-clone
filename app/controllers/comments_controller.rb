class CommentsController < ApplicationController
  def create
    @insta_post = InstaPost.find(params[:insta_post_id])
    @comment = @insta_post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to insta_post_path(@insta_post)
    else
      render "insta_post/show_comments"
    end
  end

  def destroy
    @comment = Comment.Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to request.referrer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :picture)
  end
end
