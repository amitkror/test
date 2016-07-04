module Admissions::CommentsHelper

  def commentable_link(comment)
    begin

      if comment.commentable_type == "ForumThread"
        ft = comment.commentable
        return link_to('show', forum_forum_thread_path(ft.forum, ft)) + " | "
      end

      return link_to('show', comment.commentable) + " | "

    rescue
      return ""
    end
  end

end
