class Admissions::ReferralCodesController < ApplicationController
  load_resource find_by: :permalink
  # authorize_resource
  def create
    @referral_code = ReferralCode.new(params[:referral_code])
    if @referral_code.save
      render json: @referral_code
    else
      render json: "Fail"
    end
  end
end
