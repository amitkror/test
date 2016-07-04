class Profile::ForumThreadsController < Profile::ProfileController

  def index
    @forum_threads = current_user.forum_threads.ordered
  end
end
