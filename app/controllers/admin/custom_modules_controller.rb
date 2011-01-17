class Admin::CustomModulesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  uses_tiny_mce
  layout "admin"

  def index
    @title = "Modules"

  end

  def new
    @title = "Add Module"
    @custom_module = CustomModule.new

    respond_to do |format|
      format.html
      format.xml { render :xml => @custom_module }
    end
  end

  def edit
    @custom_module = CustomModule.find(params[:id])
  end

  def create
    if params[:custom_module][:title].present? && params[:custom_module][:content].present?
      @custom_module = CustomModule.new(:title => params[:custom_module][:title],
                                        :header => params[:custom_module][:header],
                                        :content => params[:custom_module][:content],
                                        :sidebar => params[:custom_module][:sidebar])
    end

    respond_to do |format|
      if @custom_module.save
        format.html { redirect_to(admin_modules_path) }
        format.xml  { render :xml => @custom_module, :status => :created, :location => @custom_module }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @custom_module.errors, :status => :unprocessable_entity }
      end
   end
  end

  def update
    @custom_module = CustomModule.find(params[:id])

    respond_to do |format|
      if @custom_module.update_attributes(params[:custom_module])
        format.html { redirect_to(admin_modules_path, :notice => 'Custom Module was successfully updated!') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @custom_module.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @custom_module = CustomModule.find(params[:id])
    @custom_module.destroy

    respond_to do |format|
      format.html { redirect_to(admin_modules_path, :notice => 'Custom Module was successfully deleted!') }
      format.xml  { head :ok }
    end
  end

  private

  def define_page
    @current_page = 'modules'
  end
end

