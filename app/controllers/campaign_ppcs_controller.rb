class CampaignPpcsController < ApplicationController
  layout 'advertise_ppc'

  def show
    @campaign_ppc = CampaignPpc.find_by_permalink!(params[:id])
    @contact = Contact.new
  end

end
