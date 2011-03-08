class Admin::CustomModulesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :define_page
  uses_tiny_mce
  layout "admin"

  def new
    @title = "Add Module"
    @custom_module = CustomModule.new
    @locations = Template.all_locations
    @last_id = CustomModuleContent.last.id

    respond_to do |format|
      format.html
      format.xml { render :xml => @custom_module }
    end
  end

  def edit
    @custom_module = CustomModule.find(params[:id])
    @locations = @custom_module.all_contents
    @last_id = CustomModuleContent.last.id
  end

  def create
    @custom_module = CustomModule.new(params[:custom_module])

    respond_to do |format|
      if @custom_module.save

        if params[:locations].present?
          params[:locations].each do |location, content|
            all_contents = '';
            content.each { |key, value| all_contents += value }
            CustomModuleContent.create(:custom_module_id => @custom_module.id,
                                       :content => all_contents,
                                       :location => location)
          end
        end

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

        if params[:locations].present?
          params[:locations].each do |location, content|
            all_contents = '';
            content.each { |key, value| all_contents += value }
            exist_content = CustomModuleContent.where(:custom_module_id => @custom_module.id, :location => location).first
            if exist_content.present?
              exist_content.update_attribute(:content, all_contents)
            else
              CustomModuleContent.create(:custom_module_id => @custom_module.id,
                                         :content => all_contents,
                                         :location => location)
            end
          end
        end

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

