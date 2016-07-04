class FolderMailer < ActionMailer::Base

  CONFIG = YAML.load_file("#{Rails.root}/config/nyccollegeline.yml")[Rails.env]  
  LOGO = File.read(Rails.root.join('app/assets/images/emails/logo.png'))
  default from: CONFIG['mail_sender']

  def send_to_friend(folder_email, recipient_email, include_cc)

    return if recipient_email.blank?

    @folder = folder_email.folder
    @message = folder_email.message
    @sender = folder_email.user_username
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/emails/logo.png'))
    mail(
      from: CONFIG['mail_sender'],
      to: recipient_email,
      cc: ((folder_email.cc_me && include_cc) ? folder_email.user_email : nil),
      subject: CONFIG['email_prefix'] + folder_email.subject
    ) do |format|
      format.html { render layout: 'email' }
    end
  end

  def contact_ppc_to_super(contact,cc)
    logger.info "Sent email to #{contact.inspect} on #{DateTime.now}"
    @user = contact    

    attachments.inline['logo.png'] = LOGO

    mail(
      to: 'anilkumar@mobikasa.com',
      cc: cc,      
      bcc: User.admins.pluck(:email),
      subject: CONFIG['email_prefix'] + "New PPC page contact form message"
    ) do |format|
      format.html { render layout: 'email' }
    end
  end
end