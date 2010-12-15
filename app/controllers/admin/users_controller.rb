class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  respond_to :html, :xml
  
  def index
    @title = "Users"
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    respond_with(@user) do |format| 
      format.html
      format.xml { render :xml => @user }
    end
  end
  
  def edit 
    @user = User.find(params[:id])
    respond_with(@user) do |format|
      format.html
      format.xml { render :xml => @user}
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to(admin_users_url, :notice => "Profile updated.")
    else
      render 'edit'
    end
  end
  
  def new
    @user = User.new
    respond_with(@user) do |format|
      format.html
      format.xml  { render :xml => @user }
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(admin_users_url, :notice => "User was successfully created")
    else
      render 'new'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with(@user) do |format|
      format.html { redirect_to(admin_users_url, :notice => 'User was succesfully destroyed') }
      format.xml { render :xml => @user }
    end
  end
end
