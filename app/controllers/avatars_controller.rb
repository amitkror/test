class AvatarsController < ApplicationController

  before_filter :authenticate_user!

  def create
    current_user.custom_avatar = params[:file]
    if current_user.save
      render json: {
        success: true,
        file: current_user.custom_avatar.thumb('150x150#').url,
      }
    else
      render json: { success: false, errors: current_user.errors }
    end
  end

  def destroy
    current_user.custom_avatar = nil
    if current_user.save
      render json: {
        success: true,
      }
    else
      render json: { success: false, errors: current_user.errors }
    end
  end

end
