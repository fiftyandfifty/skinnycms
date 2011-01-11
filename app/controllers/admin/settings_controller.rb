class Admin::SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"

  def index
    @title = "Settings"

  end

  private

  def define_page
    @current_page = 'settings'
  end
end

