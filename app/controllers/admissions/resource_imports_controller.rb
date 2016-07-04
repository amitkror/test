class Admissions::ResourceImportsController < Admissions::AdmissionsController
  load_resource find_by: :permalink
  authorize_resource
  def new
    @resource_import = ResourceImport.new
  end

  def create
    @resource_import = ResourceImport.new(params[:resource_import])
    if @resource_import.save
      @resource_import.process_import
      redirect_to admin_resources_path, notice: "Yay. Imported!"
    else
      render :new
    end
  end
end
