class SiteController < ApplicationController
  def index
  end

  def explore
    @posts = Post.all
  end

  def about
  end

  def help
  end

  def tools
  end

  def blog
  end
end
