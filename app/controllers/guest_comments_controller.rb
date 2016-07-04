class GuestCommentsController < ApplicationController
  def create
    commentable = find_commentable

    @comment = commentable.comments.build(params[:comment])
    @comment.guest_user = GuestUser.find(session[:guest_user_id])

    @comment_size = commentable.comments.size

    unless @comment.save
      render js: "alert('All fields are required');"
    else
      commentable.last_commented_at = Time.now
      commentable.last_commenter = current_user
      commentable.on_commented if commentable.methods.include? :on_commented
      commentable.save
      render 'comments/create'
    end
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
