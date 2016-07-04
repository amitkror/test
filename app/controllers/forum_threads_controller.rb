class ForumThreadsController < ForumsController

  before_filter :authenticate_user!, only: [:new, :create]

  def new
    @forum_thread = ForumThread.new
    @forum_thread.forum_id = params[:forum_id] unless params[:forum_id].blank?
  end

  def create
    @forum_thread = ForumThread.new(params[:forum_thread])
    @forum_thread.user = current_user
    if @forum_thread.save
      redirect_to forum_forum_thread_path(@forum_thread.forum, @forum_thread),
        notice: "Thanks, your thread has been posted."
    else
      render :new
    end
  end

  def show
    
    @forum = Forum.find_by_permalink!(params[:forum_id])
    @forum_thread = @forum.forum_threads.find_by_permalink!(params[:id]) 
    if user_signed_in? && current_user.verified?
      cookies[:signin_forum] = ''  if cookies[:signin_forum].nil?
      cookies[:signin_forum] = cookies[:signin_forum] + " " + "#{@forum.permalink}"
    else  
      cookies[:recent_forum] = ''  if cookies[:recent_forum].nil?
      cookies[:recent_forum] = cookies[:recent_forum] + " " + "#{@forum.permalink}"
    end 
  end

  def destroy
    @forum_thread = ForumThread.find_by_permalink!(params[:id])

    unless @forum_thread.user == current_user
      authorize! :destroy, @forum_thread
    end
    @forum_thread.destroy
    redirect_to forums_path, notice: "Deleted #{@forum_thread.name}"
  end
end