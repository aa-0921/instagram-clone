class InstaPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @insta_post = current_user.insta_posts.build(insta_post_params)
    if @insta_post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @insta_post = Insta_post.find(params[:id])
    @comment = Comemnt.new
    @user = User.find_by(id: @insta_post.user_id)
  end

  def destroy
    @insta_post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end

  private

  def insta_post_params
    params.require(:insta_post).permit(:content, :picture)
  end

  def correct_user
    @insta_post = current_user.insta_posts.find_by(id: params[:id])
    redirect_to root_url if @insta_post.nil?
  end
end
