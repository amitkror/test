class DailyMailer < ActionMailer::Base

  CONFIG = YAML.load_file("#{Rails.root}/config/nyccollegeline.yml")[Rails.env]

  def send_digest(uid, updated_ids, commented_ids, thread_ids)

    #logger.error "#{uid}, #{updated_ids}, #{commented_ids}"

    usr = User.where(id: uid).select(["username", "email" ]).first

    @updated_resources = Resource.where("id in (?)", updated_ids)\
      .select("name, teaser, body, permalink")
    @commented_resources = Resource.where("id in (?)", commented_ids)\
      .select("name, teaser, body, permalink")
    @threads = ForumThread.where("id in (?)", thread_ids)\
      .select("id, name, permalink, forum_id")

    #logger.error "updated #{@updated_resources} comment_resources #{@commented_resources} threads? #{@threads}"

    unless @updated_resources.any? || @commented_resources.any? || @threads.any?
      return
    end

    #logger.error "---\n\n#{CONFIG['mail_sender']} #{CONFIG['email_prefix']} #{usr.email} #{usr.username}\n\n---"

    logger.info "Sent email to #{usr.email} on #{DateTime.now}"

    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/emails/logo.png'))
    mail(
      from: CONFIG['mail_sender'],
      to: usr.email,
      subject: CONFIG['email_prefix'] + "#{usr.username}, Daily Digest for #{l Date.today, format: :headline}"
    ) do |format|
      format.html { render layout: 'email' }
    end
  end
end
