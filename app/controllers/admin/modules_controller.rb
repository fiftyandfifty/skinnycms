class Admin::ModulesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"

  def index
    @title = "Modules"

  end

  private

  def define_page
    @current_page = 'modules'
  end
end

