class Admin::CategoriesController < ApplicationController
  before_filter :authenticate_user!
  layout "application"
  respond_to :html, :xml
  
  def index
    @title = "Categories"
    @categories = Category.all
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @categories }
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to  do |format|
      format.html
      format.xml  { render :xml => @category }
    end
  end

  def new    
    @category = Category.new

    respond_to do |format|
      format.html
      format.xml { render :xml => @category}
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(admin_categories_url, :notice => 'Category was successfully created!') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end      
  end

  def update
    @category = Category.find(params[:id])
    
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(admin_categories_url, :notice => 'Category was successfully updated!') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    
    respond_to do |format|
      format.html { redirect_to(admin_categories_url, :notice => 'Category was successfully deleted!') }
      format.xml  { head :ok }
    end
  end
end
