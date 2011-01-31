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
    if params[:header_new].present?
      header_blocks = '';
      header_params = params[:header_new]
      header_params.each do |key, value|
        header_blocks += value
      end
    end

    if params[:content_new].present?
      content_blocks = '';
      content_params = params[:content_new]
      content_params.each do |key, value|
        content_blocks += value
      end
    end

    if params[:sidebar_new].present?
      sidebar_blocks = '';
      sidebar_params = params[:sidebar_new]
      sidebar_params.each do |key, value|
        sidebar_blocks += value
      end
    end

    @custom_module = CustomModule.new(:title => params[:custom_module][:title]) if params[:custom_module][:title].present?  
    @custom_module.header = header_blocks if header_blocks.present?
    @custom_module.content = content_blocks if content_blocks.present?
    @custom_module.sidebar = sidebar_blocks if sidebar_blocks.present?

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
    if params[:custom_module][:header].present? || !params[:header_new].present?
      header_exist = []
      header_exist = params[:custom_module][:header] if params[:custom_module][:header].present?

      if params[:header_new].present?
        header_blocks = []
        header_params = params[:header_new]
        header_params.each do |key, value|
          header_blocks << value
        end
      end

      header_result = header_exist.to_s + header_blocks.to_s
    end

    if params[:custom_module][:content].present? || params[:content_new].present?
      content_exist = []
      content_exist = params[:custom_module][:content] if params[:custom_module][:content].present?

      if params[:content_new].present?
        content_blocks = []
        content_params = params[:content_new]
        content_params.each do |key, value|
          content_blocks << value
        end
      end

      content_result = content_exist.to_s + content_blocks.to_s
    end

    if params[:custom_module][:sidebar].present? || params[:sidebar_new].present?
      sidebar_exist = []
      sidebar_exist = params[:custom_module][:sidebar] if params[:custom_module][:sidebar].present?

      if params[:sidebar_new].present?
        sidebar_blocks = []
        sidebar_params = params[:sidebar_new]
        sidebar_params.each do |key, value|
          sidebar_blocks << value
        end
      end

      sidebar_result = sidebar_exist.to_s + sidebar_blocks.to_s
    end


    @custom_module = CustomModule.find(params[:id])
    @custom_module.title = params[:custom_module][:title] if params[:custom_module][:title].present?
    @custom_module.header = header_result if header_result.present?
    @custom_module.content = content_result if content_result.present?
    @custom_module.sidebar = sidebar_result if sidebar_result.present?

    respond_to do |format|
      if @custom_module.save
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

