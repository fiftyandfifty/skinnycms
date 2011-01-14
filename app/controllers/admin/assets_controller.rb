class Admin::AssetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"

  def index
    @title = "Assets"
    @videos = Vimeo::Simple::User.all_videos("user4101556")
    Fleakr.api_key = "d4666eafcdb675929ad56f51412393e5"
    user = Fleakr.user('http://www.flickr.com/photos/51384181@N04/')
    @galleries = user.sets

  end

  private

  def define_page
    @current_page = 'assets'
  end
end

