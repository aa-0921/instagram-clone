class InstaPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @insta_post = current_user.insta_posts.build(insta_post_params)
    if @insta_post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

  def insta_post_params
    params.require(:insta_post).permit(:content)
  end
end
