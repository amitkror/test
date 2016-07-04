class Profile::ReferralEmailsController < Profile::ProfileController
  def new
    @contest = Contest.find(params[:contest_id])
    @ref_code = current_user.referral_code(@contest.id)

    @referral_email = ReferralEmail.new({
      subject: current_user.username + ReferralEmail::DEFAULT_SUBJECT,
      over: params[:over] == 'true'
    })
    render layout: 'layouts/popup' if @referral_email.over
  end

  def create
    @contest = Contest.find(params[:contest_id])

    @referral_email = ReferralEmail.new(params[:referral_email])
    @referral_email.user = current_user

    if @referral_email.save
      recipients = @referral_email.recipient.split(',')
      cc = true
      recipients.each do |recipient|
        if is_email(recipient.strip)
          ReferralMailer.delay(queue: 'referral_mailer')\
            .send_to_friend(@referral_email, recipient.strip, cc)
          cc = false
        else
          logger.info "\n\n\n--- You can't fool me! #{recipient} \n\n"
        end
      end

      redirect_to new_profile_contest_referral_email_path(
          over: (@referral_email.over ? "true" : "")),
          notice: "Your email has been sent"
    elsif @referral_email.over == true || @referral_email.over == 'true'
      render :new, layout: 'layouts/popup'
    else
      render :new
    end
  end

  def is_email(str)
    str.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
  end
end
