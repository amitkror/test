class Profile::FolderEmailsController < Profile::ProfileController

  before_filter :set_folder, only: [:new, :create]

  def new
    @folder_email = FolderEmail.new({
      subject: current_user.username + FolderEmail::DEFAULT_SUBJECT,
      over: params[:over] == 'true'
    })
    render layout: 'layouts/popup' if @folder_email.over
  end

  def create
    @folder_email = FolderEmail.new(params[:folder_email])
    @folder_email.user = current_user
    @folder_email.folder = @folder

    if @folder_email.save
      recipients = @folder_email.recipient.split(',')
      cc = true
      recipients.each do |recipient|
        if is_email(recipient.strip)
          FolderMailer.delay(queue: 'folder_mailer')\
            .send_to_friend(@folder_email, recipient.strip, cc)
          cc = false
        else
          logger.info "\n\n\n--- You can't fool me! #{recipient} \n\n"
        end
      end

      redirect_to new_profile_folder_folder_email_path(@folder,
        over: (@folder_email.over ? "true" : "")),
          notice: "Your email has been sent"
    elsif @folder_email.over == true || @folder_email.over == 'true'
      render :new
    else
      render :new
    end
  end

  def is_email(str)
    str.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
  end

  private
    def set_folder
      @folder = current_user.folders.find_by_id!(params[:folder_id])
    end

end
