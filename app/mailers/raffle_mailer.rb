class RaffleMailer < ActionMailer::Base
  CONFIG = YAML.load_file("#{Rails.root}/config/nyccollegeline.yml")[Rails.env]

  def send_invite(user, contest)
    logger.info "Sent email to #{user.email} on #{DateTime.now}"

    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/emails/logo.png'))
    mail(
      from: CONFIG['mail_sender'],
      to: user.email,
      subject: CONFIG['email_prefix'] + "#{user.username}, Raffle Invite for #{l Date.today, format: :headline}"
    ) do |format|
      format.html { render layout: 'email' }
    end
  end
end
