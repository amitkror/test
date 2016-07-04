class Admissions::SiteSettingsController < Admissions::AdmissionsController
  before_filter :set_site_setting
  load_resource find_by: :permalink
  authorize_resource

  def edit
  end

  def update
    if @site_setting.update_attributes(params[:site_setting])

      expire_fragment('home')

      redirect_to edit_admin_site_setting_path(@site_setting),
          notice: site_setting_flash(@site_setting).html_safe
    else
      render :edit
    end
  end

  private

    def set_site_setting
      @site_setting = SiteSetting.find_by_id!(params[:id])
    end

    def site_setting_flash(site_setting)
      render_to_string partial: "flash", locals: { site_setting: site_setting }
    end
end
