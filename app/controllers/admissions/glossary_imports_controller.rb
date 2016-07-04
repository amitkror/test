class Admissions::GlossaryImportsController < Admissions::AdmissionsController
  load_resource find_by: :permalink
  authorize_resource
  def new
    @glossary_import = GlossaryImport.new
  end

  def create
    @glossary_import = GlossaryImport.new(params[:glossary_import])
    if @glossary_import.save
      @glossary_import.process_import
      redirect_to admin_glossary_terms_path, notice: "Yay. Imported!"
    else
      render :new
    end
  end
end
