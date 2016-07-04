class ContactSubmissionsController < ApplicationController

  def index
    redirect_to new_contact_submission_path
  end

  def new
    @page = Page.find_by_absolute_url!('/contact-us')
    @contact_submission = ContactSubmission.new
  end

  def create
    @contact_submission = ContactSubmission.new(params[:contact_submission])
    if @contact_submission.save
      redirect_to new_contact_submission_path,
        notice: "Thank you for contacting us."
    else
      @page = Page.find_by_absolute_url!('/contact-us')
      render :new
    end
  end
end