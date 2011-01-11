class Admin::ImagesController < ApplicationController  
  before_filter :authenticate_user!
  before_filter :define_page
  layout "admin"
  
  def index
    @title = "Images"
    @images = Image.order("created_at DESC")
  end
  
  def new
    @image = Image.new
  end
  
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to(admin_images_url, :notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        flash[:notice] = 'Image wasn\'t successfully uploaded!'
        format.html { redirect_to(admin_images_url) }
      else
        flash[:error] = 'Image wasn\'t uploaded. Try again!'
        format.html { render :action => "new" }
      end
    end
  end
  
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(admin_images_url) }
      format.xml  { head :ok }
    end
  end

  def define_page
    @current_page = 'assets'
  end
end
