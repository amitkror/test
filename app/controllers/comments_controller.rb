class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    commentable = find_commentable

    @comment = commentable.comments.build(params[:comment])
    @comment.user = current_user

    @comment_size = commentable.comments.size

    unless @comment.save
      render js: "alert('All fields are required');"
    else
      commentable.last_commented_at = Time.now
      commentable.last_commenter = current_user
      commentable.on_commented if commentable.methods.include? :on_commented
      commentable.save
    end
    if commentable.class.to_s == 'BlogPost'
      author = User.find(commentable.user_id)
      usr_email_array = Array.new
            
      if author.user_settings.notify_blog_comments == true
        if current_user.email != author.email
          usr_email_array << author.email
        end  
      end    
    
      commentable.comments.each do |c|
        if current_user.email != c.user.email || c.user.email != author.email
          if c.user.user_settings.notify_resource_comments == true
            usr_email_array << c.user.email
          end  
        end 
      end
      usr_email_array = usr_email_array.uniq

      if usr_email_array.size > 0        
        QuestionMailer.delay(queue: 'questions').email_notification_comment(commentable,@comment,usr_email_array)
      end  
    end  
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment unless @comment.user == current_user
    @comment.destroy
  end

  private
    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          cls = $1.classify.constantize
          if cls.column_names.include? 'permalink'
            return cls.find_by_permalink!(value)
          else
            return cls.find_by_id!(value)
          end
        end
      end
      nil
    end

end