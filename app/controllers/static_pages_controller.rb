class StaticPagesController < ApplicationController
  def home
    @insta_post = current_user.insta_posts.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
