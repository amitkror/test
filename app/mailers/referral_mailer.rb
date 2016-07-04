class ReferralMailer < ActionMailer::Base
  CONFIG = YAML.load_file("#{Rails.root}/config/nyccollegeline.yml")[Rails.env]

  def send_to_friend(referral_email, recipient_email, include_cc)

    return if recipient_email.blank?

    @message = referral_email.message
    @sender = referral_email.user.username
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/emails/logo.png'))
    mail(
      from: CONFIG['mail_sender'],
      to: recipient_email,
      cc: ((referral_email.cc_me && include_cc) ? referral_email.user.email : nil),
      subject: CONFIG['email_prefix'] + referral_email.subject
    ) do |format|
      format.html { render layout: 'email' }
    end
  end
end
