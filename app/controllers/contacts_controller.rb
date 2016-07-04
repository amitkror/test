class ContactsController < ApplicationController

  
  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      #QuestionMailer.delay(queue: 'questions').contact_ppc_to_super(@contact)
      cc_email = CampaignPpc.find(params[:contact][:ppc_id]).contact_form_email
      cc_email = nil if !cc_email      
      FolderMailer.contact_ppc_to_super(@contact, cc_email).deliver
      flash[:notice] = "Thank you for your message. We will contact you soon!"
      redirect_to :back
      return
    else
      flash[:alert] = "Something went wrong. Cannot send message."
      render :back
    end
  end

end