class Admin::AssetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"

  def index
    @title = "Assets"

  end

  private

  def define_page
    @current_page = 'assets'
  end
end

