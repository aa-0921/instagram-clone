class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @insta_post = InstaPost.find(params[:insta_post_id])
    unless @insta_post.like?(current_user)
      @insta_post.like(current_user)
      @insta_post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @insta_post = Like.find(params[:id]).insta_post
    if @insta_post.like?(current_user)
      @insta_post.unlike(current_user)
      @insta_post.reload

      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
