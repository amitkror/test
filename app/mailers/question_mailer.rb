class QuestionMailer < ActionMailer::Base

  CONFIG = YAML.load_file("#{Rails.root}/config/nyccollegeline.yml")[Rails.env]
  LOGO = File.read(Rails.root.join('app/assets/images/emails/logo.png'))
  default from: CONFIG['mail_sender']

  def send_to_admins(question)

    @question = question

    attachments.inline['logo.png'] = LOGO
    set_avatar(@question.user)

    mail(
      to: CONFIG['mail_recipient'],
      bcc: User.admins.pluck(:email),
      subject: CONFIG['email_prefix'] + "New ask an adviser question"
    ) do |format|
      format.html { render layout: 'email' }
    end
  end  

  def automated_password_recovery(user)
    logger.info "Sent email to #{user.email} on #{DateTime.now}"

    @user = user

    attachments.inline['logo.png'] = LOGO
    mail(
      from: CONFIG['mail_sender'],
      to: user.email,
      subject: CONFIG['email_prefix'] + "Reset password instructions"
    ) do |format|
      format.html { render layout: 'email' }
    end
  end

  def partial_user_welcome(user, password)
    logger.info "Sent welcome email to #{user.email} on #{DateTime.now}"

    @user = user
    @password = password

    attachments.inline['logo.png'] = LOGO
    mail(
      from: CONFIG['mail_sender'],
      to: user.email,
      subject: CONFIG['email_prefix'] + "Welcome to join NYC College Line"
    ) do |format|
      format.html { render layout: 'email' }
    end
  end

  def send_assigned(question)
    @question = question

    attachments.inline['logo.png'] = LOGO
    set_avatar(@question.user)

    mail(
      to: question.adviser_email,
      bcc: [CONFIG['mail_bcc']],
      subject: CONFIG['email_prefix'] + "You have been assigned a question"
    ) do |format|
      format.html { render layout: 'email' }
    end
  end

  def send_answered(question)
    @question = question

    attachments.inline['logo.png'] = LOGO
    set_avatar(@question.adviser)

    mail(
      to: question.user_email,
      bcc: [CONFIG['mail_bcc']],
      subject: CONFIG['email_prefix'] + "Your question has an answer"
    ) do |format|
      format.html { render layout: 'email' }
    end
  end

  def email_notification_comment(blog_post,comment,usr_email_array)
    @comment = comment.content
    @blog_post_title = blog_post.title
    @last_commenter = User.find(blog_post.last_commenter).username

    # usr_email_array = Array.new
    # @author_email = User.find(blog_post.user_id).email

    
    # blog_post.comments.each do |c|
    #   if current_user_email != c.user.email
    #     if c.user.user_setting.notify_resource_comment == true
    #       usr_email_array << c.user.email
    #     end  
    #   end
    # end
    #usr_email_array = usr_email_array.uniq    

    attachments.inline['logo.png'] = LOGO    

    mail(
      to: usr_email_array,
      #cc: @author_email,
      subject: CONFIG['email_prefix'] + "There is a new comment on blog post."
    ) do |format|
      format.html { render layout: 'email' }
    end

  end

  def send_commented(question)
    @question = question

    if @question.is_a?(GuestQuestion)
      @user = question.last_commenter.nil? ? question.adviser : question.guest_user
    else
      @user = question.last_commenter_id == question.user_id ? question.adviser : question.user
    end

    attachments.inline['logo.png'] = LOGO
    set_avatar(@question.last_commenter)

    mail(
      to: @user.email,
      bcc: [CONFIG['mail_bcc']],
      subject: CONFIG['email_prefix'] + "There is a new comment on your question."
    ) do |format|
      format.html { render layout: 'email' }
    end
  end

  private
    def set_avatar(user)
      begin
        attachments.inline['avatar.png'] = File.read(user.avatar.thumb('75x75#').path)
      rescue
        logger.error "No avatar found"
      end
    end
end
